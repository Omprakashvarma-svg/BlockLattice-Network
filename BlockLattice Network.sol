// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockLatticeNetwork {

    // Define a struct to represent a Node in the network
    struct Node {
        address nodeAddress;
        string nodeName;
        bool isActive;
    }

    // Mapping to store nodes based on their address
    mapping(address => Node) public nodes;

    // Event to notify when a new node is added
    event NodeAdded(address indexed nodeAddress, string nodeName);

    // Event to notify when a node is removed
    event NodeRemoved(address indexed nodeAddress);

    // Modifier to check if the node is active
    modifier onlyActiveNode() {
        require(nodes[msg.sender].isActive, "Only active nodes can perform this action.");
        _;
    }

    // Function to add a node to the network
    function addNode(string memory _nodeName) public {
        require(bytes(_nodeName).length > 0, "Node name is required.");
        require(nodes[msg.sender].nodeAddress == address(0), "Node already exists.");

        // Create a new node
        nodes[msg.sender] = Node({
            nodeAddress: msg.sender,
            nodeName: _nodeName,
            isActive: true
        });

        emit NodeAdded(msg.sender, _nodeName);
    }

    // Function to remove a node from the network
    function removeNode() public onlyActiveNode {
        address nodeAddress = msg.sender;
        nodes[nodeAddress].isActive = false;

        emit NodeRemoved(nodeAddress);
    }

    // Function to check if a node is active
    function isNodeActive(address _nodeAddress) public view returns (bool) {
        return nodes[_nodeAddress].isActive;
    }
}
