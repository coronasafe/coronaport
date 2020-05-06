type t = {
  district_id: int,
  lb_code: string,
  lb_type: string,
  name: string,
  lb_csn: int,
};

let district_id = t => t.district_id;
let lb_type = t => t.lb_type;
let name = t => t.name;
let lb_csn = t => t.lb_csn;
let lb_code = t => t.lb_code;

let districts = lsgArray => lsgArray |> Js.Array.filter(a => a.lb_csn == 3);

let decode = json => {
  Json.Decode.{
    district_id: json |> field("district_id", int),
    lb_type: json |> field("lb_type", string),
    name: json |> field("lb_name_full", string),
    lb_csn: json |> field("lb_type_csn", int),
    lb_code: json |> field("lb_code", string),
  };
};

let panchayats = (d, lsgArray) =>
  lsgArray |> Js.Array.filter(a => a.district_id == d.district_id);
