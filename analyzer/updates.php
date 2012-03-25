<?php
$id = $_GET['id'];

$connect = mysql_connect( "localhost","xoul","jx$0yu!L6o7u4x" );
mysql_select_db( "4shared_downloader_analyzer", $connect );

// 존재하지 않는 id일 경우
$result = mysql_query( "select * from ids where id=$id", $connect );
if( mysql_num_rows( $result ) == 0 )
{
	mysql_close( $connect );
	return;
}

$version = $_GET['version'];

// 이미 같은 버전이 기록되어 있을 경우
$result = mysql_query( "select * from `updates` where id=$id && version='$version'", $connect );
if( mysql_num_rows( $result ) > 0 )
{
	mysql_close( $connect );
	return;
}

$date = date( "Y-m-d H:i:s",time() );

mysql_query ( 'SET NAMES utf8' );
mysql_query( "INSERT INTO `4shared_downloader_analyzer`.`updates` (`id`, `version`, `time`) VALUES ($id, '$version', '$date')" );
mysql_close( $connect );
?>