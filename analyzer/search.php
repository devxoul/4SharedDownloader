<?php
$id = $_GET["id"];
$debug = $_GET['debug'];

$connect = mysql_connect("localhost","xoul","jx$0yu!L6o7u4x");
mysql_select_db("4shared_downloader_analyzer",$connect);
$result = mysql_query("select * from ids where id=$id",$connect);
$row = mysql_num_rows($result);
echo $row;
if($row == 0)
{
	echo "Invalid id";
	mysql_close($connect);
	return;
}

$search = $_GET["search"];

// 중복된 검색결과 제외 (페이지 넘길 때 등)
$result = mysql_query( "SELECT `search` FROM `searches` WHERE id=$id ORDER BY `index` DESC LIMIT 0, 1" );
$last_search = mysql_fetch_array( $result );

if( utf8_decode( $search ) == $last_search[0] )
{
	echo "Same search";
	mysql_close( $connect );
	return;
}

if( $debug == 'y' )
{
	echo "Debugging!";
	mysql_close( $connect );
	return;
}

$current_date = date("Y-m-d H:i:s",time());
mysql_query ('SET NAMES utf8');
mysql_query("INSERT INTO `4shared_downloader_analyzer`.`searches` (`id`, `search`, `time`) VALUES ($id, '$search', '$current_date')");
mysql_close($connect);
?>
