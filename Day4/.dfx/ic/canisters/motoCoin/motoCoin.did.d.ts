import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Subaccount],
}
export interface MotoCoin {
  'airdrop' : ActorMethod<[], Result>,
  'balanceOf' : ActorMethod<[Account], bigint>,
  'name' : ActorMethod<[], string>,
  'symbol' : ActorMethod<[], string>,
  'totalSupply' : ActorMethod<[], bigint>,
  'transfer' : ActorMethod<[Account, Account, bigint], Result>,
}
export type Result = { 'ok' : null } |
  { 'err' : string };
export type Subaccount = Uint8Array | number[];
export interface _SERVICE extends MotoCoin {}
