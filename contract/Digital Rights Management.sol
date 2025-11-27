// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DecentralizedTaskManager
 * @dev A simple contract that allows users to create, complete, and retrieve tasks.
 */
contract Project {
    
    struct Task {
        uint256 id;
        string description;
        bool isCompleted;
        address owner;
    }

    uint256 private nextTaskId = 1;
    mapping(uint256 => Task) private tasks;

    event TaskCreated(uint256 taskId, string description, address owner);
    event TaskCompleted(uint256 taskId, address owner);

    /**
     * @dev Create a new task.
     * @param _description The description of the task.
     */
    function createTask(string memory _description) external {
        tasks[nextTaskId] = Task({
            id: nextTaskId,
            description: _description,
            isCompleted: false,
            owner: msg.sender
        });

        emit TaskCreated(nextTaskId, _description, msg.sender);
        nextTaskId++;
    }

    /**
     * @dev Mark a task as completed. Only the owner can complete it.
     * @param _taskId The ID of the task to complete.
     */
    function completeTask(uint256 _taskId) external {
        Task storage task = tasks[_taskId];
        require(task.owner == msg.sender, "Not task owner");
        require(!task.isCompleted, "Task already completed");

        task.isCompleted = true;
        emit TaskCompleted(_taskId, msg.sender);
    }

    /**
     * @dev Retrieve task details.
     * @param _taskId The ID of the task.
     */
    function getTask(uint256 _taskId) external view returns (Task memory) {
        return tasks[_taskId];
    }
}

