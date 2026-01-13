// Function to calculate final result Takes exam marks, assignment marks, and a callback function
function calculateResult(examMarks, assignmentMarks, callback) {

    // Calculate total score
    const finalScore = examMarks + assignmentMarks;

    // Call the callback function and pass final score
    callback(finalScore);
}

// Callback function to display pass or fail result
function displayResult(score) {

    // Check pass/fail condition
    if (score >= 40) {
        console.log("Final Score:", score);
        console.log("Result: PASS");
    } else {
        console.log("Final Score:", score);
        console.log("Result: FAIL");
    }
}

// Calling the main function
// 30 = exam marks, 15 = assignment marks
calculateResult(25, 15, displayResult);
