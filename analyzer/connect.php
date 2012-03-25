<?php
$ip = getRealIpAddr();
$id = $_GET["id"];
$connect = mysql_connect("localhost","xoul","jx$0yu!L6o7u4x");
mysql_select_db("4shared_downloader_analyzer",$connect);
$result = mysql_query("select * from ids where id=$id",$connect);
$row = mysql_num_rows($result);
echo $row;
if($row == 0)
{
        mysql_close($connect);
        return;
}
else
{
        $current_date = date("Y-m-d H:i:s",time());
        mysql_query("INSERT INTO `4shared_downloader_analyzer`.`connects` (`id`, `ip`, `time`) VALUES ($id, '$ip', '$current_date');");
        mysql_close($connect);
}
function getRealIpAddr()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
    {
      $ip=$_SERVER['HTTP_CLIENT_IP'];
    }
    elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
    {
      $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    }
    else
    {
      $ip=$_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}
?>
