<?php
  if ($_POST['note'] != '')
  {
    $f = fopen("/data/notes.txt", "a+");
    $t = $_POST['note']."\n";
    fwrite($f, $t);
    fclose($f);
  }

  header('Location: index.php');
?>