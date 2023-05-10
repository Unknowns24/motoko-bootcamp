export const idlFactory = ({ IDL }) => {
  const Time = IDL.Int;
  const Homework = IDL.Record({
    'title' : IDL.Text,
    'completed' : IDL.Bool,
    'dueDate' : Time,
    'description' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Result_1 = IDL.Variant({ 'ok' : Homework, 'err' : IDL.Text });
  return IDL.Service({
    'addHomework' : IDL.Func([Homework], [IDL.Nat], []),
    'deleteHomework' : IDL.Func([IDL.Nat], [Result], []),
    'getAllHomework' : IDL.Func([], [IDL.Vec(Homework)], []),
    'getHomework' : IDL.Func([IDL.Nat], [Result_1], []),
    'getPendingHomework' : IDL.Func([], [IDL.Vec(Homework)], []),
    'markAsCompleted' : IDL.Func([IDL.Nat], [Result], []),
    'searchHomework' : IDL.Func([IDL.Text], [IDL.Vec(Homework)], []),
    'updateHomework' : IDL.Func([IDL.Nat, Homework], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
