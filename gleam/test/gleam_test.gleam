import gleam
import gleam/should

pub fn hello_world_test() {
  gleam.hello_world()
  |> should.equal("Hello, from gleam!")
}
