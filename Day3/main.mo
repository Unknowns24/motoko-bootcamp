import Type "Types";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";

actor class StudentWall() {
	type Message = Type.Message;
	type Content = Type.Content;

	stable var messageIdCount : Nat = 0;

	private func _hashNat(n : Nat) : Hash.Hash = return Text.hash(Nat.toText(n));
	let wall = HashMap.HashMap<Nat, Message>(0, Nat.equal, _hashNat);

	// Add a new message to the wall
	public shared ({ caller }) func writeMessage(c : Content) : async Nat {
		// Id logic
		let id : Nat = messageIdCount;
		messageIdCount += 1;

		// Create the new message
		var newMessage : Message = {
			content = c;
			creator = caller;
			vote = 0;
		};

		// Instert Data into wall
		wall.put(id, newMessage);

		return id;
	};

	// Get a specific message by ID
	public shared query func getMessage(messageId : Nat) : async Result.Result<Message, Text> {
		let messageData : ?Message = wall.get(messageId);

		switch (messageData) {
			case (null) {
				return #err "The requested message does not exist.";
			};
			case (?message) {
				return #ok message;
			};
		};
	};

	// Update the content for a specific message by ID
	public shared ({ caller }) func updateMessage(messageId : Nat, c : Content) : async Result.Result<(), Text> {
		var isAuth : Bool = not Principal.isAnonymous(caller);

		if (not isAuth) {
			return #err "You must be authenticated to validate that you are the creator of the message!";
		};

		let messageData : ?Message = wall.get(messageId);

		switch (messageData) {
			case (null) {
				return #err "The requested message does not exist.";
			};
			case (?message) {
				if (message.creator != caller) {
					return #err "You are not the creator of this message!";
				};

				let updatedMessage : Message = {
					creator = message.creator;
					content = c;
					vote = message.vote;
				};

				wall.put(messageId, updatedMessage);

				return #ok();
			};
		};
	};

	// Delete a specific message by ID
	public shared ({ caller }) func deleteMessage(messageId : Nat) : async Result.Result<(), Text> {
		let messageData : ?Message = wall.get(messageId);

		switch (messageData) {
			case (null) {
				return #err "The requested message does not exist.";
			};
			case (?message) {
				if (message.creator != caller) {
					return #err "You are not the creator of this message!";
				};

				ignore wall.remove(messageId);

				return #ok();
			};
		};

		return #ok();
	};

	// Voting
	public func upVote(messageId : Nat) : async Result.Result<(), Text> {
		let messageData : ?Message = wall.get(messageId);

		switch (messageData) {
			case (null) {
				return #err "The requested message does not exist.";
			};
			case (?message) {
				let updatedMessage : Message = {
					creator = message.creator;
					content = message.content;
					vote = message.vote + 1;
				};

				wall.put(messageId, updatedMessage);

				return #ok();
			};
		};

		return #ok();
	};

	public func downVote(messageId : Nat) : async Result.Result<(), Text> {
		let messageData : ?Message = wall.get(messageId);

		switch (messageData) {
			case (null) {
				return #err "The requested message does not exist.";
			};
			case (?message) {
				let updatedMessage : Message = {
					creator = message.creator;
					content = message.content;
					vote = message.vote - 1;
				};

				wall.put(messageId, updatedMessage);

				return #ok();
			};
		};

		return #ok();
	};

	// Get all messages
	public func getAllMessages() : async [Message] {
		let messagesBuff = Buffer.Buffer<Message>(0);

		for (msg in wall.vals()) {
			messagesBuff.add(msg);
		};

		return Buffer.toArray<Message>(messagesBuff);
	};

	// Get all messages ordered by votes
	public func getAllMessagesRanked() : async [Message] {
		let messagesBuff = Buffer.Buffer<Message>(0);

		for (msg in wall.vals()) {
			messagesBuff.add(msg);
		};

		var messages = Buffer.toVarArray<Message>(messagesBuff);

		// Reversed buble sort
		var size = messages.size();

		// substract 1 to size only if size is > than 0 to prevent errors
		if (size > 0) {
			size -= 1;
		};

		for (a in Iter.range(0, size)) {
			var maxIndex = a;

			for (b in Iter.range(a, size)) {
				if (messages[b].vote > messages[a].vote) {
					maxIndex := b;
				};
			};

			let tmp = messages[maxIndex];
			messages[maxIndex] := messages[a];
			messages[a] := tmp;
		};

		return Array.freeze<Message>(messages);
	};
};
