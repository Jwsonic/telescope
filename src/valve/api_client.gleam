import decode.{Decoder, field, int, list, map2, map5, string}
import gleam/dynamic.{Dynamic}
import gleam/http.{Get, Https, Request}
import gleam/httpc
import gleam/jsone
import gleam/option.{None, Some}
import gleam/result

pub type Player {
  Player(account_id: Int, hero_id: Int)
}

pub type Match {
  Match(
    players: List(Player),
    duration: Int,
    match_id: Int,
    match_seq_num: Int,
    start_time: Int,
  )
}

fn player_decoder() -> Decoder(Player) {
  map2(Player, field("account_id", int()), field("hero_id", int()))
}

fn match_decoder() -> Decoder(Match) {
  map5(
    Match,
    field("players", list(player_decoder())),
    field("duration", int()),
    field("match_id", int()),
    field("match_seq_num", int()),
    field("start_time", int()),
  )
}

fn response_decoder() -> Decoder(List(Match)) {
  match_decoder()
  |> list()
  |> field("matches", _)
  |> field("result", _)
}

pub fn decode_response(json: String) -> Result(List(Match), String) {
  try data = jsone.decode(json)

  decode.decode_dynamic(data, response_decoder())
}

pub fn fetch(
  host: String,
  path: String,
  query: String,
) -> Result(List(Match), String) {
  let response =
    Request(
      method: Get,
      headers: [],
      body: "",
      scheme: Https,
      host: host,
      port: None,
      path: path,
      query: Some(query),
    )
    |> httpc.send()
  case response {
    Ok(response) -> decode_response(response.body)
    Error(_) -> Error("Utf8 error")
  }
}
