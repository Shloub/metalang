module Html = Dom_html

let doc = Html.document

let get x = Js.Opt.get x (fun () -> assert false)
let element id = get (doc##getElementById(Js.string id))

let to_remove = ref None

let click_replicate _ =
  let top = element "top" in
  Dom.appendChild top (doc##createTextNode(Js.string "begin"));

  let stderr = match Html.tagged (element "stderr") with
    | Html.Textarea t ->
      Dom.appendChild top (doc##createTextNode(Js.string "TEXTAREA"))
      ; t
    | _ -> Dom.appendChild top (doc##createTextNode(Js.string "ERROR!")) ; assert false  in
  let process_error e =
    let () = begin
      ignore (Format.flush_str_formatter ());
      e Format.str_formatter;
    end in
    let se = Format.flush_str_formatter () in
    let () = stderr##value <- (Js.string se) in
    () in

  let textarea = match Html.tagged (element "input_text") with
    | Html.Textarea t ->
      Dom.appendChild top (doc##createTextNode(Js.string "TEXTAREA"))
      ; t
    | _ -> Dom.appendChild top (doc##createTextNode(Js.string "ERROR!")) ; assert false  in
  let copy = element "copy" in
  let txt : Js.js_string Js.t = textarea##value in

  let select_lang = match Html.tagged (element "language") with
    | Html.Select e -> e
    | _ -> assert false in
  let lang : Libmetalang.L.key = Obj.magic (Js.to_string select_lang##value) in

  let output = Libmetalang.test_process
    process_error
    lang (Js.to_string txt) in
  begin match !to_remove with
  Some node -> Dom.removeChild copy node | _ -> () end ;

  let node = doc##createTextNode (Js.string output) in
  to_remove := Some node ;

  Dom.appendChild copy node ;

  Dom.appendChild top (doc##createTextNode(Js.string "end!!!"));

  Js._true

let run _ =

  let replicate = element "replicate" in
  replicate##onclick <- Html.handler click_replicate ;
  begin match Html.tagged (element "language") with
    | Html.Select e -> e##onchange <- Html.handler click_replicate
    | _ -> () end ;

  let top = element "top" in
  Dom.appendChild top (doc##createTextNode(Js.string "yo!"));
  let output = Html.createDiv doc in
  output##id <- Js.string "output" ;
  output##style##whiteSpace <- Js.string "pre" ;
  Dom.appendChild top output ;
  Dom.appendChild output
    (doc##createTextNode(Js.string "Hey, this is caml!"));

  Js._false

let _ = Html.window##onload <- Html.handler run
