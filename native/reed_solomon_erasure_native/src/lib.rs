#[macro_use] extern crate rustler;
// #[macro_use] extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;
#[macro_use] extern crate reed_solomon_erasure;

use rustler::{NifEnv, NifTerm, NifError, NifResult, NifEncoder};
use rustler::types::NifBinary;
use reed_solomon_erasure::ReedSolomon;

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.ReedSolomonErasure.Native",
    [("encode", 3, encode)],
    None
}

fn encode<'a>(env:NifEnv<'a>, args:&[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let data_shards: usize = try!(args[0].decode());
    let parity_shards: usize = try!(args[1].decode());
    let msg: NifBinary = try!(args[2].decode());

    let rs = match ReedSolomon::new(data_shards, parity_shards) {
        Ok(rs) => rs,
        Err(_) => return Err(NifError::BadArg)
    };

    Ok((atoms::ok(), &rs).encode(env))
}
