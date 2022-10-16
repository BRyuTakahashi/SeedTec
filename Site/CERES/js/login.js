function login(){
    var user = in_user.value
    var senha = in_senha.value

    if(user == "CERESadmin" && senha == "1234"){
        window.location.assign('dashboard.html')

    } else{
        alert("⚠ Usuário ou senha incorretos!")
    }
}