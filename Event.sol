// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Event {
    address public Organizer;

    constructor() {
        Organizer = msg.sender;
    }

    modifier onlyOrganizer() {
        require(msg.sender == Organizer, "not Organizer");
        _;
    }

    function setOrganizer(address _newOrganizer) external onlyOrganizer {
        require(_newOrganizer != address(0), "Invalid address");
        Organizer = _newOrganizer;
    }

    struct EventData {
        // string name of the event
        string EventName;
        // Event Description
        string EventDescription;
        // total number of tickets offered
        uint256 NumTickets;
        // Event date
        uint256 EventDate;

        //we need number of tickets remaining
    }

    // Called each time an event is created
    event EventCreated(uint256 indexed EventId);

    function Create_Event(
        string calldata EventName,
        string calldata EventDescription,
        uint256 NumTickets,
        uint256 EventDate
    ) external onlyOrganizer returns (uint256) {
        //we need check for exist event
        //we need check number of ticket ( not = 0 )

        uint256 EventId = EventData(
            EventName,
            EventDescription,
            NumTickets,
            EventDate
        );
        emit EventCreated(EventId);
        return EventId;
    }

    mapping(uint256 => EventData) public events;

    //function to retrive the data of a certain event
    function getEventData(uint256 event_id)
        external
        view
        returns (EventData memory)
    {
        return events[event_id];
    }
}
