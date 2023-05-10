import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Homework {
  'title' : string,
  'completed' : boolean,
  'dueDate' : Time,
  'description' : string,
}
export type Result = { 'ok' : null } |
  { 'err' : string };
export type Result_1 = { 'ok' : Homework } |
  { 'err' : string };
export type Time = bigint;
export interface _SERVICE {
  'addHomework' : ActorMethod<[Homework], bigint>,
  'deleteHomework' : ActorMethod<[bigint], Result>,
  'getAllHomework' : ActorMethod<[], Array<Homework>>,
  'getHomework' : ActorMethod<[bigint], Result_1>,
  'getPendingHomework' : ActorMethod<[], Array<Homework>>,
  'markAsCompleted' : ActorMethod<[bigint], Result>,
  'searchHomework' : ActorMethod<[string], Array<Homework>>,
  'updateHomework' : ActorMethod<[bigint, Homework], Result>,
}
