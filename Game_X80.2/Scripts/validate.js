

function validate_Login() {
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    if (email === '' || password === '') {
        document.getElementById("status").innerHTML="Please enter all fields"
        return false;
    }

    if (email.indexOf("@") == -1 || email.indexOf(".") == -1) {
        document.getElementById("valid-login").innerHTML = "Please Enter Valid Email Adress";
        return false;
    }
}

function validate_date( ) {
    var dateString = document.getElementById("date").value;
    alert(dateString);
    // Parse the date parts to integers
    var parts = dateString.split("-");
    var day = parseInt(parts[2], 10);
    var month = parseInt(parts[1], 10);
    var year = parseInt(parts[0], 10);
    alert(day);
    alert(month);
    alert(year);

    // Check the ranges of month and year
    if (year < 1920 || year > 2019 || month == 0 || month > 12)
        return false;

    var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Adjust for leap years
    if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
        monthLength[1] = 29;

    // Check the range of the day
    return day > 0 && day <= monthLength[month - 1];
}

function validate_Signup() {
    var email = document.getElementById("email").value;
    var firstName = document.getElementById("firstName").value;
    var lastName = document.getElementById("lastName").value;
    var password = document.getElementById("password").value;
    
    for (var i = 0; i < 9; i++) {
        if (firstName.indexOf(i) != -1) {
            document.getElementById("valid-firstName").innerHTML = "Please Enter a Valid Name";
        }
        if (lastName.indexOf(i) != -1) {
            document.getElementById("valid-lastName").innerHTML = "Please Enter a Valid Name";
        }
    }
    if (email.indexOf("@") == -1 || email.indexOf(".") == -1) {
        document.getElementById("valid-email").innerHTML = "Please Enter a Valid Email Adress";
        return false;
    }
    var strongPassword = new RegExp("^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\_^&\*])(?=.{8,})");
    var IsStrong = strongPassword.test(password);

    if (IsStrong == false) {
        document.getElementById("valid-password").innerHTML = "Your Password is weak";
        return false;
    }

    var validDate = validate_date();
    if (validDate == false)
    {
        document.getElementById("valid-date").innerHTML = "Please Enter a valid date";
    }
    
    
    return true;

}


