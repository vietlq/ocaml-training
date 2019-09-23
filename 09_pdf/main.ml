let objects = [(1,
Pdf.Dictionary
  [("/Type", Pdf.Name "/Page");
   ("/Parent", Pdf.Indirect 3);
   ("/Resources",
      Pdf.Dictionary
        [("/Font",
         Pdf.Dictionary
           [("/F0",
             Pdf.Dictionary
               [("/Type", Pdf.Name "/Font");
                ("/Subtype", Pdf.Name "/Type1");
                ("/BaseFont", Pdf.Name "/Times-Italic")])])]);
   ("/MediaBox",
     Pdf.Array
       [Pdf.Float 0.; Pdf.Float 0.;
       Pdf.Float 595.275590551; Pdf.Float 841.88976378]);
       ("/Rotate", Pdf.Integer 0);
       ("/Contents", Pdf.Array [Pdf.Indirect 4])]);
  (2,
    Pdf.Dictionary
      [("/Type", Pdf.Name "/Catalog");
       ("/Pages", Pdf.Indirect 3)]);
  (3,
    Pdf.Dictionary
      [("/Type", Pdf.Name "/Pages");
       ("/Kids", Pdf.Array [Pdf.Indirect 1]);
       ("/Count", Pdf.Integer 1)]);
  (4,
    Pdf.Stream
      (Pdf.Dictionary [("/Length", Pdf.Integer 53)],
       "1 0 0 1 50 770 cm BT /F0 36 Tf (Hello, World!) Tj ET"))]

let hello =
{Pdf.version = (1, 1);
    Pdf.objects = objects;
    Pdf.trailer =
    Pdf.Dictionary
    [("/Size", Pdf.Integer 5);
      ("/Root", Pdf.Indirect 2)]}

(*
  Solution to Chapter 13. Question 2.
*)
let c13q2_answer_1 = Pdf.Name "/Name"

let c13q2_answer_2 = Pdf.String "(Quartz Crystal)"

let c13q2_answer_3 = Pdf.Dictionary [
  ("/Type", Pdf.Name "/ObjStm");
  ("/N", Pdf.Integer 100);
  ("/First", Pdf.Integer 807);
  ("/Length", Pdf.Integer 1836);
  ("Filter", Pdf.Name "FlateDecode")
]

let c13q2_answer_4 = Pdf.Array [
  (Pdf.Integer 1);
  (Pdf.Integer 2);
  (Pdf.Float 1.5);
  (Pdf.String "(black)");
]

let c13q2_answer_5 = Pdf.Array [
  (Pdf.Integer 1);
  (Pdf.Integer 2);
  (Pdf.Integer 0);
  (Pdf.String "R");
]

(*
  Solution to Chapter 13. Question 3.
*)
type tree = Lf | Br of tree * int * tree

let rec pdfobject_of_tree tree =
  match tree with
  | Lf -> Pdf.Boolean false
  | Br (left, key, right) -> Pdf.Array [
    pdfobject_of_tree left;
    Pdf.Integer key;
    pdfobject_of_tree right;
  ]

let rec tree_of_pdfobject pdfobj =
  match pdfobj with
  | Pdf.Boolean false -> Lf
  | Pdf.Array [
    left;
    Pdf.Integer key;
    right;
  ] -> Br (tree_of_pdfobject left, key, tree_of_pdfobject right)
  | _ -> failwith "Invalid tree shape!"

(*
  Solution to Chapter 13. Question 4.
*)
let rec set_rotate_90 (pdfobj : Pdf.pdfobject) : Pdf.pdfobject =
  match pdfobj with
  | Pdf.Dictionary dict ->
    Pdf.Dictionary (List.map set_rotate_90_impl dict)
  | _ as po -> po
and set_rotate_90_impl (key, value) =
  if key = "/Rotate" then (key, Pdf.Integer 90)
  else (key, set_rotate_90 value)

let () =
  let tree1 = Br (Lf, 1, Br (Br (Lf, 3, Lf), 2, Lf)) in
  tree1
  |> pdfobject_of_tree
  |> tree_of_pdfobject
  |> ignore
