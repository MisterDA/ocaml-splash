open Graphics

let title = "3 Billion Devices Run OCaml"

let legend =
  [
    "Computers, Printers, Routers, Cell Phones,";
    "MirageOS, RaspberryPi, Servers, My Grandmother's Toaster,";
    "Xmas lights, Some other awesome stuff that I don't know about, ...";
  ]

let orange = 0xf18c06
let gray = rgb 127 127 127

let center ~width y text =
  let w, _ = text_size text in
  moveto ((width - w) / 2) y;
  draw_string text

let center_paragraph ~width y text =
  List.fold_left (fun y line ->
      let w, h = text_size line in
      moveto ((width - w) / 2) (y - h);
      draw_string line;
      y - h - 8)
    y text
  |> ignore

let () =
  open_graph " 500x300";
  let width, height = size_x (), size_y () in
  set_color black;
  auto_synchronize true;
  let center = center ~width in
  let center_paragraph = center_paragraph ~width in
  Random.self_init ();
  let t = ref (Unix.gettimeofday ()) in
  let bar_x = ref 100 in
  try
    while true do
      moveto 0 0;
      set_color black;
      center 190 title;
      set_color gray;
      center_paragraph 150 legend;
      set_color orange;
      moveto 0 0;
      fill_rect 0 0 width 50;
      set_color white;
      center 15 "OCaml";
      moveto 0 0;
      draw_image (Data.logo ()) 0 (height - 75);
      moveto 0 85;
      let t' = Unix.gettimeofday () in
      let elapsed = t' -. !t in
      if elapsed > 2. then begin
          bar_x := Random.int width;
          t := t'
        end;
      set_color white;
      fill_rect 0 (height - 85) width 10;
      set_color green;
      fill_rect 0 (height - 85) !bar_x 10;
      let st = wait_next_event [ Mouse_motion; Button_down; Key_pressed; Poll ] in
      synchronize ();
      Unix.sleepf (1./.60.);
      if st.keypressed then raise Exit;
    done
  with Exit -> ()
