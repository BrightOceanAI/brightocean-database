/* 
===========================================================================
================================== DDL ====================================
=========================================================================== 
*/

CREATE TABLE BTO_USUARIO (
    id_usuario NUMBER PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    ocupacao VARCHAR(50) NOT NULL
);
 
CREATE TABLE BTO_CAMERA (
    id_camera NUMBER,
    PRIMARY KEY (id_camera),
    modelo VARCHAR(75) NOT NULL,
    localizacao VARCHAR(75) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL
);
 
CREATE TABLE BTO_FOTOGRAFIA (
    id_fotografia NUMBER,
    PRIMARY KEY (id_fotografia),
    link_fotografia VARCHAR(150) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    id_camera NUMBER NOT NULL,
    FOREIGN KEY (id_camera) REFERENCES BTO_CAMERA(id_camera) 
);
 
CREATE TABLE BTO_RECIFE_CORAIS (
    id_recife NUMBER,
    PRIMARY KEY (id_recife),
    nome_recife VARCHAR(200) NOT NULL,
    classificacao VARCHAR(20) NOT NULL,
    localizacao VARCHAR(70) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    em_restauracao SMALLINT,
    estrategia_restauracao VARCHAR(100)
);
 
CREATE TABLE BTO_DIAGNOSTICO (
    id_diagnostico NUMBER,
    PRIMARY KEY (id_diagnostico),
    saude VARCHAR(20) NOT NULL,
    data_diagnostico DATE NOT NULL,
    id_fotografia NUMBER NOT NULL,
    FOREIGN KEY (id_fotografia) REFERENCES BTO_FOTOGRAFIA(id_fotografia),
    id_recife NUMBER NOT NULL,
    FOREIGN KEY (id_recife) REFERENCES BTO_RECIFE_CORAIS (id_recife)
);

CREATE TABLE BTO_LOG_ERROS (
    id_log NUMBER PRIMARY KEY,
    nome_procedure VARCHAR2(100),
    usuario VARCHAR2(50),
    data_erro TIMESTAMP,
    codigo_erro VARCHAR2(50),
    mensagem_erro VARCHAR2(4000)
);

CREATE SEQUENCE SEQ_BTO_LOG_ERROS;

CREATE OR REPLACE TRIGGER TRG_BTO_LOG_ERROS
BEFORE INSERT ON BTO_LOG_ERROS
FOR EACH ROW
BEGIN
    :NEW.id_log := SEQ_BTO_LOG_ERROS.NEXTVAL;
END;


/* 
===========================================================================
============================== PRODUCERES =================================
=========================================================================== 
*/


CREATE OR REPLACE PROCEDURE carregar_dados_usuario(
    p_id_usuario NUMBER,
    p_nome VARCHAR2,
    p_cpf VARCHAR2,
    p_email VARCHAR2,
    p_senha VARCHAR2,
    p_ocupacao VARCHAR2
)
IS
    v_error_message VARCHAR2(4000);
    v_error_code NUMBER;
BEGIN
    INSERT INTO BTO_USUARIO (id_usuario, nome, cpf, email, senha, ocupacao)
    VALUES (p_id_usuario, p_nome, p_cpf, p_email, p_senha, p_ocupacao);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_error_code := SQLCODE;
        v_error_message := 'Duplicated value';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_usuario', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN NO_DATA_FOUND THEN
        v_error_code := SQLCODE;
        v_error_message := 'No data found';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_usuario', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_usuario', USER, SYSTIMESTAMP, v_error_code, v_error_message);
END;
/


CREATE OR REPLACE PROCEDURE carregar_dados_camera (
    p_id_camera NUMBER,
    p_modelo VARCHAR2,
    p_localizacao VARCHAR2,
    p_latitude FLOAT,
    p_longitude FLOAT
)
IS
    v_error_message VARCHAR2(4000);
    v_error_code NUMBER;
BEGIN
    INSERT INTO BTO_CAMERA (id_camera, modelo, localizacao, latitude, longitude)
    VALUES (p_id_camera, p_modelo, p_localizacao, p_latitude, p_longitude);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_error_code := SQLCODE;
        v_error_message := 'Duplicated value';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_camera', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN NO_DATA_FOUND THEN
        v_error_code := SQLCODE;
        v_error_message := 'No data found';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_camera', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_camera', USER, SYSTIMESTAMP, v_error_code, v_error_message);
END;
/


CREATE OR REPLACE PROCEDURE carregar_dados_fotografia (
    p_id_fotografia NUMBER,
    p_link_fotografia VARCHAR2,
    p_data_hora TIMESTAMP,
    p_id_camera INT
)
IS
    v_error_message VARCHAR2(4000);
    v_error_code NUMBER;
BEGIN
    INSERT INTO BTO_FOTOGRAFIA (id_fotografia, link_fotografia, data_hora, id_camera)
    VALUES (p_id_fotografia, p_link_fotografia, p_data_hora, p_id_camera);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_error_code := SQLCODE;
        v_error_message := 'Duplicated value';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_fotografia', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN NO_DATA_FOUND THEN
        v_error_code := SQLCODE;
        v_error_message := 'No data found';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_fotografia', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'carregar_dados_fotografia', USER, SYSTIMESTAMP, v_error_code, v_error_message);
END;
/

CREATE OR REPLACE PROCEDURE carregar_dados_recife (
    p_id_recife NUMBER,
    p_nome_recife VARCHAR2,
    p_classificacao VARCHAR2,
    p_localizacao VARCHAR2,
    p_latitude FLOAT,
    p_longitude FLOAT,
    p_em_restauracao SMALLINT,
    p_estrategia_restauracao VARCHAR2
)
IS
    v_error_message VARCHAR2(4000);
    v_error_code NUMBER;
BEGIN
    INSERT INTO BTO_RECIFE_CORAIS (id_recife, nome_recife, classificacao, localizacao, latitude, longitude, em_restauracao, estrategia_restauracao)
    VALUES (p_id_recife, p_nome_recife, p_classificacao, p_localizacao, p_latitude, p_longitude, p_em_restauracao, p_estrategia_restauracao);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_error_code := SQLCODE;
        v_error_message := 'Duplicated value';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_RECIFE_CORAIS', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN NO_DATA_FOUND THEN
        v_error_code := SQLCODE;
        v_error_message := 'No data found';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_RECIFE_CORAIS', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_RECIFE_CORAIS', USER, SYSTIMESTAMP, v_error_code, v_error_message);
END;
/


CREATE OR REPLACE PROCEDURE carregar_dados_diagnostico (
    p_id_diagnostico NUMBER,
    p_saude VARCHAR2,
    p_data_diagnostico DATE,
    p_id_fotografia INT,
    p_id_recife INT
)
IS
    v_error_message VARCHAR2(4000);
    v_error_code NUMBER;
BEGIN
    INSERT INTO BTO_DIAGNOSTICO (id_diagnostico, saude, data_diagnostico, id_fotografia, id_recife)
    VALUES (p_id_diagnostico, p_saude, p_data_diagnostico, p_id_fotografia, p_id_recife);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_error_code := SQLCODE;
        v_error_message := 'Duplicated value';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_DIAGNOSTICO', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN NO_DATA_FOUND THEN
        v_error_code := SQLCODE;
        v_error_message := 'No data found';
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_DIAGNOSTICO', USER, SYSTIMESTAMP, v_error_code, v_error_message);
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        INSERT INTO BTO_LOG_ERROS (id_log, nome_procedure, usuario, data_erro, codigo_erro, mensagem_erro)
        VALUES (SEQ_BTO_LOG_ERROS.NEXTVAL, 'LOAD_BTO_DIAGNOSTICO', USER, SYSTIMESTAMP, v_error_code, v_error_message);
END;

/* 
===========================================================================
========================== BLOCOS ANÔNIMOS ================================
=========================================================================== 
*/


-- Bloco Anônimo para listar todos os usuários e suas ocupações
DECLARE
    CURSOR usuarios_cursor IS
        SELECT nome, ocupacao FROM BTO_USUARIO;
    usuario_rec usuarios_cursor%ROWTYPE;
BEGIN
    OPEN usuarios_cursor;
    LOOP
        FETCH usuarios_cursor INTO usuario_rec;
        EXIT WHEN usuarios_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || usuario_rec.nome || ', Ocupação: ' || usuario_rec.ocupacao);
    END LOOP;
    CLOSE usuarios_cursor;
END;

-- Bloco Anônimo para listar todas as câmeras e sua localização
DECLARE
    CURSOR cameras_cursor IS
        SELECT modelo, localizacao FROM BTO_CAMERA;
    camera_rec cameras_cursor%ROWTYPE;
BEGIN
    OPEN cameras_cursor;
    LOOP
        FETCH cameras_cursor INTO camera_rec;
        EXIT WHEN cameras_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Modelo: ' || camera_rec.modelo || ', Localização: ' || camera_rec.localizacao);
    END LOOP;
    CLOSE cameras_cursor;
END;

-- Bloco Anônimo para exibir todas as fotografias tiradas por uma câmera específica
DECLARE
    v_camera_id BTO_CAMERA.id_camera%TYPE := 123; -- Defina o ID da câmera desejada
    CURSOR fotografias_cursor IS
        SELECT link_fotografia, data_hora FROM BTO_FOTOGRAFIA WHERE id_camera = v_camera_id;
    fotografia_rec fotografias_cursor%ROWTYPE;
BEGIN
    OPEN fotografias_cursor;
    LOOP
        FETCH fotografias_cursor INTO fotografia_rec;
        EXIT WHEN fotografias_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Link: ' || fotografia_rec.link_fotografia || ', Data/Hora: ' || fotografia_rec.data_hora);
    END LOOP;
    CLOSE fotografias_cursor;
END;

-- Bloco Anônimo para exibir informações sobre recifes de corais
DECLARE
    CURSOR exemplo_cursor IS
        SELECT id_recife, nome_recife, em_restauracao FROM BTO_RECIFE_CORAIS ORDER BY id_recife;
    recife_rec exemplo_cursor%ROWTYPE;
    v_total_geral NUMBER := 0;
    v_sub_total NUMBER := 0;
    v_grupo_anterior BTO_RECIFE_CORAIS.em_restauracao%TYPE := NULL;
BEGIN
    OPEN exemplo_cursor;
    LOOP
        FETCH exemplo_cursor INTO recife_rec;
        EXIT WHEN exemplo_cursor%NOTFOUND;
        
        IF recife_rec.em_restauracao <> v_grupo_anterior THEN
            IF v_grupo_anterior IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('Sub-Total: ' || v_sub_total);
                v_total_geral := v_total_geral + v_sub_total;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Grupo: ' || recife_rec.em_restauracao);
            v_sub_total := 0;
            v_grupo_anterior := recife_rec.em_restauracao;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || recife_rec.id_recife || ', Nome: ' || recife_rec.nome_recife || ', Em Restauração: ' || recife_rec.em_restauracao);
        v_sub_total := v_sub_total + recife_rec.em_restauracao;
    END LOOP;
    CLOSE exemplo_cursor;
    
    IF v_grupo_anterior IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Sub-Total: ' || v_sub_total);
        v_total_geral := v_total_geral + v_sub_total;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Total Geral: ' || v_total_geral);
END;