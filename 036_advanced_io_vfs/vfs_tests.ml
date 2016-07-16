open Vfs ;;

print_endline "vfs_tests\n----\n" ;;

print_vfs Nil ;;

print_vfs (File ("myfile.txt", ())) ;;

print_vfs (Dir ("secret", [||])) ;;

let lochness_text = "Loch Ness (Scottish Gaelic: Loch Nis) is a large, deep, freshwater loch in the Scottish Highlands extending for approximately 23 miles (37 km) southwest of Inverness. Its surface is 52 ft (16 m) above sea level. Loch Ness is best known for alleged sightings of the cryptozoological Loch Ness Monster, also known affectionately as \"Nessie\". It is connected at the southern end by the River Oich and a section of the Caledonian Canal to Loch Oich. At the northern end there is the Bona Narrows which opens out into Loch Dochfour, which feeds the River Ness and a further section of canal to Inverness. It is one of a series of interconnected, murky bodies of water in Scotland; its water visibility is exceptionally low due to a high peat content in the surrounding soil." ;;
let ufo_text = "An unidentified flying object, or UFO, in its most general definition, is any apparent anomaly in the sky that is not identifiable as a known object or phenomenon. Culturally, UFOs are associated with claims of visitation by extraterrestrial life or government-related conspiracy theories, and have become popular subjects in fiction. While UFOs are often later identified, sometimes identification may not be possible owing to the usually low quality of evidence related to UFO sightings (generally anecdotal evidence and eyewitness accounts)." ;;

let vfs1 = (Dir ("X-Files", [|
    File ("Lochness", lochness_text) ;
    Dir ("Hot", [|
        File ("UFO", ufo_text)
    |])
|])) ;;

print_vfs vfs1 ;;

print_vfs_chars vfs1 ;;

let vfs2 = read_dir "." ;;
print_vfs_chars vfs2 ;;

