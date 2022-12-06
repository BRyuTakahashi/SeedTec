var database = require("../database/config");

function buscarUltimasMedidas(idArmazem, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        horario,
                        FORMAT(horario, 'HH:mm:ss') as horario_grafico
                    from metrica
                    where fkArmazem = ${idArmazem}
                    order by idMetrica desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        select temperatura, umidade, horario, DATE_FORMAT(horario,'%H:%i:%s') as horario_grafico
        from metrica where fkArmazem = ${idArmazem}
        order by idMetrica desc limit ${limite_linhas}`

    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idArmazem) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, horario, 108) as horario_grafico, 
                        fkArmazem 
                        from metrica where fkArmazem = ${idArmazem} 
                    order by idMetrica desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        select temperatura, umidade, DATE_FORMAT(horario,'%H:%i:%s') as horario_grafico, fkArmazem 
        from metrica where fkArmazem = ${idArmazem} 
        order by idMetrica desc limit 1`;
        
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}