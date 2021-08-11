#!/bin/bash

#Para fazer os testes de geração do backup será necessário criar os diretórios especificados em backup_dir e dar permissão chmod -x a este script
#Após o script estar funcionando corretamente será necessário definir o agendamento dentro da crontab pelo comando "crontab -e" e inserindo "0 0 * * * /scripts/mysql_backup.sh"

 
DB_NAME='sgdados' # Nome do banco de dados
DB_USER='root' # Usuario do banco
DB_PASS='@253791gH' # Senha do banco
DB_PARAM='--add-drop-table --add-locks --extended-insert --single-transaction -quick' # Parametros para o backup https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
 
MYSQLDUMP=/usr/bin/mysqldump # Caminho para o binário do mysqldump
BACKUP_DIR=/backup/mysql # Caminho para salvar os backups
DIAS=7 # Quantos dias de backups deseja manter
 
DATE=`date +%Y-%m-%d`
BACKUP_NAME=mysql-$DATE.sql
BACKUP_TAR=mysql-$DATE.tar
BACKUP_BZ2=mysql-$DATE.tar.bz2
 
echo "Iniciando o processo de backup..."
 
#Gerando arquivo sql
echo "Gerando backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME"
$MYSQLDUMP $DB_NAME $DB_PARAM -u $DB_USER -p$DB_PASS > $BACKUP_DIR/$BACKUP_NAME
 
# Compactando arquivo em tar
echo "Consolidando arquivo em tar ..."
tar -cf $BACKUP_DIR/$BACKUP_TAR -C $BACKUP_DIR $BACKUP_NAME
 
# Compactando arquivo com bzip2
echo "  -- Compactando arquivo em bzip2 ..."
bzip2 $BACKUP_DIR/$BACKUP_BZ2
 
# Excluindo arquivos brutos
echo "  -- Excluindo arquivos desnecessarios ..."
rm -rf $BACKUP_DIR/$BACKUP_NAME
 
# Excluindo arquivos mais antigos
find /backup/mysql -name "*.tar.bz2" -type f -mtime +$DIAS -exec rm -f {} \;