export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Subaccount = IDL.Vec(IDL.Nat8);
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(Subaccount),
  });
  const MotoCoin = IDL.Service({
    'airdrop' : IDL.Func([], [Result], []),
    'balanceOf' : IDL.Func([Account], [IDL.Nat], ['query']),
    'name' : IDL.Func([], [IDL.Text], ['query']),
    'symbol' : IDL.Func([], [IDL.Text], ['query']),
    'totalSupply' : IDL.Func([], [IDL.Nat], []),
    'transfer' : IDL.Func([Account, Account, IDL.Nat], [Result], []),
  });
  return MotoCoin;
};
export const init = ({ IDL }) => { return []; };
