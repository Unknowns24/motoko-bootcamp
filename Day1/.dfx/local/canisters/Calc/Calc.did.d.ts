import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'add' : ActorMethod<[number], number>,
  'div' : ActorMethod<[number], [] | [number]>,
  'floor' : ActorMethod<[], bigint>,
  'mul' : ActorMethod<[number], number>,
  'power' : ActorMethod<[number], number>,
  'reset' : ActorMethod<[], undefined>,
  'see' : ActorMethod<[], number>,
  'sqrt' : ActorMethod<[], number>,
  'sub' : ActorMethod<[number], number>,
}
