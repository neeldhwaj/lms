pragma solidity ^0.4.0;


contract lms {
    address owner;

    // event MemberAdded(string name, address account);

    enum State {
        Available,
        Borrowed,
        Overdue,
        Lost
    }

    struct Book {
        string title;
        string author;
        string publisher;
        address owner;
        State state;
        uint lastIssueDate;
        uint rating;
    }

    struct Member {
        string name;
        address account;
        uint numNewBooks;
        // mapping (uint => Book) books;
    }

    uint numBooks;
    uint numMembers;
    mapping (uint => Book) catalog;
    mapping (uint => Member) members;

    modifier onlyOwner {
        if (msg.sender != owner)
            throw;
        _;
    }

    modifier onlyMember {
        for (uint i=0; i < numMembers; i++) {
            if (msg.sender == members[i].account) {
                _;
            }
        }
        throw;
    }

    function lms() {
        owner = msg.sender;
    }

    function addMember(string name, address account) public onlyOwner {
        members[numMembers++] = Member(name, account, 1);
    }

    function addBook(string title, string publisher, string author, address owner) public onlyMember {
        catalog[numBooks++] = Book({
            title: title,
            publisher: publisher,
            author: author,
            owner: owner,
            state: State.Available,
            lastIssueDate: 0,
            rating: 0
        });
    }

    function addMemberWithBooks(string name, address account, string speciallyConstructedBooksString) {
        // Each book string should be separated from the other by a single semi-colon (;)
        // Within each book string, the three fields title, author and publisher should be pipe (|) separated
        // e.g. Ethereum|Ben Abner|CreateSpace Independent Publishing Platform
        
    }

    function kill() public onlyOwner{
        selfdestruct(owner);
    }
}

