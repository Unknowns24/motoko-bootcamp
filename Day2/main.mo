
import Text "mo:base/Text";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";

actor HomeworkDiary {
    public type Homework = {
        title : Text;
        description : Text;
        dueDate : Time.Time;
        completed : Bool;
    };

    let homeworkDiary = Buffer.Buffer<Homework>(0);

    /*
        // Private function to use in lastIndexOf to search a buffer<homework> element index
        private func searchHomeworkIndex(a : Homework, b : Homework) : Bool {
            if (a.title == b.title) {
                return true;
            };
            
            return false;
        };
    */

    // Add a new homework task
    public shared func addHomework(hw : Homework) : async Nat {
        homeworkDiary.add(hw);
        //var findedId : ?Nat = Buffer.lastIndexOf(hw, homeworkDiary, searchHomeworkIndex);

        return (homeworkDiary.size() - 1);
    };

    // Get a specific homework task by id
    public shared func getHomework(hwId : Nat) : async Result.Result<Homework, Text> {
        if (homeworkDiary.size() <= hwId) {
            return #err "The requested homeworkID is higher then the homeworkDiary size";
        };

        let hw = homeworkDiary.get(hwId);

        return #ok hw;
    };

    // Update a homework task's title, description, and/or due date
    public shared func updateHomework(hwId : Nat, newHw : Homework) : async Result.Result<(), Text> {
        if (homeworkDiary.size() <= hwId) {
            return #err "The requested homeworkID is higher then the homeworkDiary size";
        };

        homeworkDiary.put(hwId, newHw);

        return #ok ()
    };

    // Mark a homework task as completed
    public shared func markAsCompleted(hwId : Nat) : async Result.Result<(), Text> { 
        if (homeworkDiary.size() <= hwId) {
            return #err "The requested homeworkID is higher then the homeworkDiary size";
        };

        var hw : Homework = homeworkDiary.get(hwId);
        var completedHw : Homework = {
            title = hw.title;
            description = hw.description;
            dueDate = hw.dueDate;
            completed = true;
        };

        homeworkDiary.put(hwId, completedHw);

        return #ok ()
    };

    // Delete a homework task by id
    public shared func deleteHomework(hwId : Nat) : async Result.Result<(), Text> {
        if (homeworkDiary.size() <= hwId) {
            return #err "The requested homeworkID is higher then the homeworkDiary size";
        };

        let x = homeworkDiary.remove(hwId);

        return #ok ()
    };

    // Get the list of all homework tasks
    public shared func getAllHomework() : async [Homework] {
        return Buffer.toArray<Homework>(homeworkDiary);
    };

    // Get the list of pending (not completed) homework tasks
    public shared func getPendingHomework() : async [Homework] {
        var pending = Buffer.clone(homeworkDiary);
        
        pending.filterEntries(func(_, hw) = hw.completed == false);

        return Buffer.toArray<Homework>(pending);
    };

    // Search for homework tasks based on a search terms
    public shared func searchHomework(searchTerm : Text) : async [Homework] {
        var search = Buffer.clone(homeworkDiary);
        
        search.filterEntries(func(_, hw) = Text.contains(hw.title, #text searchTerm) or Text.contains(hw.description, #text searchTerm));

        return Buffer.toArray<Homework>(search);
    };
}