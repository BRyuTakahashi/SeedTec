function home() {
    window.location.href = 'index.html'
}

// Máscaras dos campos

function maskTel(event) {
    let tecla = event.key;
    let telefone = event.target.value.replace(/\D+/g, "");

    if (/^[0-9]$/i.test(tecla)) {
        telefone = telefone + tecla;
        let tamanho = telefone.length;

        if (tamanho >= 12) {
            return false;
        }

        if (tamanho > 10) {
            telefone = telefone.replace(/^(\d\d)(\d{5})(\d{4}).*/, "($1) $2-$3");
        } else if (tamanho > 5) {
            telefone = telefone.replace(/^(\d\d)(\d{4})(\d{0,4}).*/, "($1) $2-$3");
        } else if (tamanho > 2) {
            telefone = telefone.replace(/^(\d\d)(\d{0,5})/, "($1) $2");
        } else {
            telefone = telefone.replace(/^(\d*)/, "($1");
        }

        event.target.value = telefone;
    }

    if (!["Backspace", "Delete"].includes(tecla)) {
        return false;
    }
}

function maskCNPJ(){
    var cnpj = document.getElementById('in_cnpj')
    
    if (cnpj.value.length == 2 || cnpj.value.length == 6){
        cnpj.value += "."
    } else if(cnpj.value.length == 10){
        cnpj.value += "/"
    } else if (cnpj.value.length == 15){
        cnpj.value += "-"
    }
        
}

function maskCEP(){
    var cep = document.getElementById('in_cep')

    if (cep.value.length == 5){
        cep.value += "-"
    }
}


// Checagem de campos e cadastro
function chkEmail() {
    var email = in_email.value

    var invalidEmail = email.indexOf("@") == -1
    var invalidEmail2 = email.length < 10

    if (email == "") {
        errorE.innerHTML = ""
    }
    else if (invalidEmail) {
        errorE.innerHTML = "Email inválido"
    } else if (invalidEmail2) {
        errorE.innerHTML = "Email inválido"
    } else {
        errorE.innerHTML = ""
    }
}

function chkPass() {
    var s1 = in_senha.value
    var s2 = in_conf_senha.value

    if (s1 != s2) {
        in_conf_senha.style.outline = '1px solid  #ff5213'
        error.innerHTML = "Senhas diferentes"
    } else {
        in_conf_senha.style.backgroundColor = '#d1f8cb'
        in_conf_senha.style.outline = 'none'
        error.innerHTML = ""
    }
}

function cadastrar() {
    var nome = in_nome.value
    var cnpj = in_cnpj.value
    var telefone = in_telefone.value
    var estado = sel_estado.value
    var cidade = in_cidade.value
    var cep = in_cep.value
    var comp = in_complemento.value
    var email = in_email.value
    var user = in_user.value
    var s1 = in_senha.value
    var s2 = in_conf_senha.value

    var invalidField = nome == '' || cnpj == '' || telefone == '' || estado == '' || cidade == '' || cep == '' || email == '' || user == '' || s1 != s2

    if (invalidField) {
        alert('Por favor, preencha todos os campos obrigatórios')
    } else {
        alert(`Usuário cadastrado com sucesso 🌱`)
        window.location.href = 'login.html'
    }

}

