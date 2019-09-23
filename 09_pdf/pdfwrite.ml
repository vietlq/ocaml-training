let rec string_of_pdfobject pdfobj =
  match pdfobj with
  | Pdf.Boolean b -> string_of_bool b
  | Pdf.Integer i -> string_of_int i
  | Pdf.Float f -> string_of_float f
  | Pdf.String s -> "(" ^ s ^ ")"
  | Pdf.Name n -> n
  | Pdf.Array a -> string_of_array a
  | Pdf.Dictionary d -> string_of_dictionary d
  | Pdf.Stream (dict, data) -> string_of_stream dict data
  | Pdf.Indirect i -> Printf.sprintf "%i 0 R" i
and string_of_array a =
  let b = Buffer.create 100 in
  Buffer.add_string b "[";
  List.iter
    (fun s ->
       Buffer.add_char b ' ';
       Buffer.add_string b (string_of_pdfobject s))
    a;
  Buffer.add_string b "]";
  Buffer.contents b
and string_of_dictionary d =
  let b = Buffer.create 100 in
  Buffer.add_string b "<<";
  List.iter
    (fun (k, v) ->
       Buffer.add_char b ' ';
       Buffer.add_string b k;
       Buffer.add_char b ' ';
       Buffer.add_string b (string_of_pdfobject v))
    d;
  Buffer.add_string b ">>";
  Buffer.contents b
and string_of_stream dict data =
  let b = Buffer.create 100 in
  List.iter (Buffer.add_string b) [
    string_of_pdfobject dict;
    "\nstream\n";
    data;
    "\nendstream\n";
  ];
  Buffer.contents b

let write_header out_ch {Pdf.version = (major, minor)} =
  output_string out_ch (Printf.sprintf "%%PDF-%i.%i\n" major minor)

let write_objects (out_ch : out_channel) (objs : (int * Pdf.pdfobject) list) : int list =
  let offsets = ref [] in
  List.iter
    (fun (objnum, obj) ->
       offsets := pos_out out_ch :: !offsets;
       output_string out_ch (Printf.sprintf "%i 0 obj\n" objnum);
       output_string out_ch (string_of_pdfobject obj);
       output_string out_ch "\nendobj\n")
    (List.sort (fun a b -> compare (fst a) (fst b)) objs);
  List.rev !offsets

let write_trailer out_ch pdf offsets =
  let startxref = pos_out out_ch in
  output_string out_ch "xref\n";
  output_string out_ch
    (Printf.sprintf "0 %i\n" (List.length pdf.Pdf.objects + 1));
  output_string out_ch "0000000000 65535 f \n";
  List.iter
    (fun offset ->
       output_string out_ch (Printf.sprintf "%010i 00000 n \n" offset))
    offsets;
  output_string out_ch "trailer\n";
  output_string out_ch (string_of_pdfobject pdf.Pdf.trailer);
  output_string out_ch "\nstartxref\n";
  output_string out_ch (string_of_int startxref);
  output_string out_ch "\n%%EOF"

let pdf_to_file pdf filename =
  let output = open_out_bin filename in
  try
    write_header output pdf;
    let offsets = write_objects output pdf.Pdf.objects in
    write_trailer output pdf offsets;
    close_out output
  with
    e -> close_out output; raise e
