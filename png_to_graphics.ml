let () =
  let img = ImageLib_unix.openfile Sys.argv.(1) in
  let ch = open_out_bin "data.ml" in
  Printf.fprintf ch "let logo () = [|";
  for y = 0 to img.Image.height - 1 do
    Printf.fprintf ch "[|";
    for x = 0 to img.Image.width - 1 do
      Image.read_rgb img x y (fun r g b ->
          if r = 0 && g = 0 && b = 0 then
            Printf.fprintf ch "0xffffff;"
          else
            Printf.fprintf ch "0x%02x%02x%02x;" r g b)
    done;
    Printf.fprintf ch "|];\n"
  done;
  Printf.fprintf ch "|] |> Graphics.make_image\n%!";
  close_out ch
