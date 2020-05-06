let str = React.string;

module Selectable = {
  type t = Lsg.t;

  let label = _t => None;

  let value = t => t |> Lsg.name;

  let searchString = t => t |> value;
  let color = _t => "gray";
};

// create a Multiselect
module Multiselect = MultiselectDropdown.Make(Selectable);

type state = {searchString: string};

let deselect = (setState, setSelected, selectable) => {
  setSelected(None);
  setState(_ => {searchString: ""});
};

[@react.component]
let make = (~lsgs, ~selected, ~setSelected, ~label) => {
  let (state, setState) = React.useState(() => {searchString: ""});
  <div className="mt-4">
    <label
      className="block text-xs font-semibold"
      htmlFor="MultiselectDropdown__search-input">
      {label |> str}
    </label>
    <Multiselect
      unselected=lsgs
      selected
      onSelect={selectable => {
        setState(_ => {searchString: ""});
        setSelected(Some(selectable));
      }}
      onDeselect={deselect(setState, setSelected)}
      value={state.searchString}
      onChange={searchString => setState(s => {...s, searchString})}
    />
  </div>;
};
