let str = React.string;

let lb = [
  (
    1,
    "Grama Panchayat",
    (2, "Block Panchayat"),
    (3, "District"),
    (10, "Muncipality"),
    (20, "Corporation"),
  ),
];

type state = {
  district: option(Lsg.t),
  lb: option(int),
  lsg: option(Lsg.t),
  lsgs: array(Lsg.t),
};

let responseCB = (setState, json) => {
  setState(state => {...state, lsgs: json |> Json.Decode.array(Lsg.decode)});
};

let errorCB = () => {
  ();
};

let getData = (setState, ()) => {
  let url = "https://raw.githubusercontent.com/coronasafe/datastore/master/JSON/Kerala_Local_Body.json";

  Api.get(url, responseCB(setState), errorCB);
  None;
};

let initalState = () => {district: None, lb: None, lsg: None, lsgs: [||]};

[@react.component]
let make = (~inputName, ~inputId) => {
  let (state, setState) = React.useState(() => initalState());
  React.useEffect1(getData(setState), [|inputName|]);
  <div>
    <div className="mt-4">
      <DropdownSearch
        label="*Select District"
        lsgs={state.lsgs |> Lsg.districts}
        selected={
          state.district |> OptionUtils.mapWithDefault(a => [|a|], [||])
        }
        setSelected={district => setState(state => {...state, district})}
      />
      {switch (state.district) {
       | Some(district) =>
         <DropdownSearch
           label="Select Panchayat*"
           lsgs={state.lsgs |> Lsg.panchayats(district)}
           selected={
             state.lsg |> OptionUtils.mapWithDefault(a => [|a|], [||])
           }
           setSelected={lsg => setState(state => {...state, lsg})}
         />
       | None => React.null
       }}
    </div>
    <input
      id=inputId
      name=inputName
      hidden=true
      required=true
      value={
        state.lsg |> OptionUtils.mapWithDefault(a => a |> Lsg.lb_code, "")
      }
    />
  </div>;
};
