import gleam/atom.{Atom}
import gleam/io
import gleam/list
import gleam/result
import gleam/should
import valve/api_client.{Match, Player}

external fn read_file(file: String) -> Result(String, Atom) =
  "file" "read_file"

pub fn match_decoder_test() {
  "../test/support/fixtures/matches.json"
  |> read_file()
  |> result.unwrap("")
  |> api_client.decode_response()
  |> result.unwrap([])
  |> list.head()
  |> should.equal(Ok(Match(
    players: [
      Player(account_id: 4294967295, hero_id: 112),
      Player(account_id: 1085611619, hero_id: 128),
      Player(account_id: 4294967295, hero_id: 100),
      Player(account_id: 4294967295, hero_id: 35),
    ],
    duration: 179,
    match_id: 5564513294,
    match_seq_num: 4670104515,
    start_time: 1597235768,
  )))
}
