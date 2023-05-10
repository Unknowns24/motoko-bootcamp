export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Answer = IDL.Tuple(IDL.Text, IDL.Nat);
  const Survey = IDL.Record({
    'title' : IDL.Text,
    'answers' : IDL.Vec(Answer),
  });
  const Content__1 = IDL.Variant({
    'Text' : IDL.Text,
    'Image' : IDL.Vec(IDL.Nat8),
    'Survey' : Survey,
  });
  const Message = IDL.Record({
    'creator' : IDL.Principal,
    'content' : Content__1,
    'vote' : IDL.Int,
  });
  const Result_1 = IDL.Variant({ 'ok' : Message, 'err' : IDL.Text });
  const Content = IDL.Variant({
    'Text' : IDL.Text,
    'Image' : IDL.Vec(IDL.Nat8),
    'Survey' : Survey,
  });
  const StudentWall = IDL.Service({
    'deleteMessage' : IDL.Func([IDL.Nat], [Result], []),
    'downVote' : IDL.Func([IDL.Nat], [Result], []),
    'getAllMessages' : IDL.Func([], [IDL.Vec(Message)], []),
    'getAllMessagesRanked' : IDL.Func([], [IDL.Vec(Message)], []),
    'getMessage' : IDL.Func([IDL.Nat], [Result_1], ['query']),
    'upVote' : IDL.Func([IDL.Nat], [Result], []),
    'updateMessage' : IDL.Func([IDL.Nat, Content], [Result], []),
    'writeMessage' : IDL.Func([Content], [IDL.Nat], []),
  });
  return StudentWall;
};
export const init = ({ IDL }) => { return []; };
