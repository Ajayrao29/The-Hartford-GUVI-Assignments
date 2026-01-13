
//
const downloadFile = (callback) => {
    console.log("Downloading file...");

    setTimeout(() => {
        console.log("Download completed");
        callback();   // execute callback after download
    }, 2000);
};

const openFile = () => {
    console.log("File opened");
};

// Function call
downloadFile(openFile);

function calculateResult(examMarks, assignmentMarks, callback) {
    const finalScore = examMarks + assignmentMarks;
    callback(finalScore);
}


function displayResult(score) {
    if (score >= 40) {
        console.log("Final Score:", score);
        console.log("Result: PASS");
    } else {
        console.log("Final Score:", score);
        console.log("Result: FAIL");
    }
}

// Function call
calculateResult(30, 15, displayResult);


