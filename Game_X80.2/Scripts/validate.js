
function validate_Login() {
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    if (email === '' || password === ' ') {
        document.getElementById("status").innerHTML="Please enter all fields"
        return false;
    }

    if (email.indexOf("@") == -1 || email.indexOf(".") == -1) {
        document.getElementById("valid-login").innerHTML = "Please Enter Valid Email Adress";
        return false;
    }
}

function validate_Signup() {
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    var firstName = document.getElementById("firstName").value;
    var lastName = document.getElementById("lastName").value;

    for (var i = 0; i < 9; i++) {
        if (firstName.indexOf(i) != -1) {
            document.getElementById("valid-firstName").innerHTML = "Please Enter Valid Name";
        }
        if (lastName.indexOf(i) != -1) {
            document.getElementById("valid-lastName").innerHTML = "Please Enter Valid Name";
        }
    }


    if (email.indexOf("@") == -1 || email.indexOf(".") == -1) {
        document.getElementById("valid-email").innerHTML = "Please Enter Valid Email Adress";
        return false;
    }
    if (password.length < 8) {
        document.getElementById("valid-password").innerHTML = "Too Short Password";
        return false;
    }
    var i, count;
    for (i = 0; i < password.length; i++) {
        if (password.charAt(i) >= 65 && password.charAt(i) <= 97) {
            count++;
        }
        else if (password.charAt(i) >= 33 && password.charAt(i) <= 57) {
            count++;
        }
    }
    if (count >= 2) {
        return true;
    }
    else {
        document.getElementById("valid-password").innerHTML = "Enter a strong Password";
        return false;
    }
    return true;
}
