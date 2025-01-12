// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DevBooking {
    struct Developer {
        string name;
        uint256 hourlyRate; // in wei
        address payable wallet;
        bool available;
    }

    struct Booking {
        address customer;
        uint256 amountPaid; // in wei
        uint256 hoursBooked; // Renamed from "hours"
        uint256 timestamp;
    }

    // State variables
    mapping(address => Developer) public developers;
    mapping(address => Booking[]) public bookings;
    address[] public developerAddresses;

    // Events
    event DeveloperRegistered(address indexed devAddress, string name, uint256 hourlyRate);
    event DeveloperUpdated(address indexed devAddress, uint256 hourlyRate, bool available);
    event BookingCreated(address indexed customer, address indexed devAddress, uint256 amountPaid, uint256 hoursBooked);

    // Register a developer
    function registerDeveloper(string memory _name, uint256 _hourlyRate) external {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(_hourlyRate > 0, "Hourly rate must be greater than 0");
        require(developers[msg.sender].wallet == address(0), "Developer already registered");

        developers[msg.sender] = Developer({
            name: _name,
            hourlyRate: _hourlyRate,
            wallet: payable(msg.sender),
            available: true
        });

        developerAddresses.push(msg.sender);

        emit DeveloperRegistered(msg.sender, _name, _hourlyRate);
    }

    // Update developer's availability and hourly rate
    function updateDeveloper(uint256 _hourlyRate, bool _available) external {
        Developer storage dev = developers[msg.sender];
        require(dev.wallet != address(0), "Developer not registered");

        dev.hourlyRate = _hourlyRate;
        dev.available = _available;

        emit DeveloperUpdated(msg.sender, _hourlyRate, _available);
    }

    // Book a developer
    function bookDeveloper(address _devAddress, uint256 _hoursBooked) external payable {
        Developer storage dev = developers[_devAddress];
        require(dev.wallet != address(0), "Developer not registered");
        require(dev.available, "Developer not available");
        require(_hoursBooked > 0, "Must book at least 1 hour");

        uint256 totalCost = dev.hourlyRate * _hoursBooked;
        require(msg.value >= totalCost, "Insufficient payment");

        // Transfer payment to the developer
        dev.wallet.transfer(totalCost);

        // Record the booking
        bookings[_devAddress].push(Booking({
            customer: msg.sender,
            amountPaid: totalCost,
            hoursBooked: _hoursBooked,
            timestamp: block.timestamp
        }));

        emit BookingCreated(msg.sender, _devAddress, totalCost, _hoursBooked);
    }

    // Get all developers
    function getAllDevelopers() external view returns (Developer[] memory) {
        Developer[] memory devList = new Developer[](developerAddresses.length);
        for (uint256 i = 0; i < developerAddresses.length; i++) {
            devList[i] = developers[developerAddresses[i]];
        }
        return devList;
    }

    // Get bookings for a developer
    function getBookings(address _devAddress) external view returns (Booking[] memory) {
        return bookings[_devAddress];
    }
}


