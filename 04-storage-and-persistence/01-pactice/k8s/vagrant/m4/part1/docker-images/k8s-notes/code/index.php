<html>
<head>
</head>
<body>
<form action="save.php" method="post">
  <label>Enter your note here:</label><br />
  <input type="text" name="note" id="note"><br /><br />
  <input type="submit" value="Save">
</form>
<?php
  if (file_exists("/data/notes.txt"))
  {
    $f = fopen("/data/notes.txt", "r");

    if ($f)
    {
      while (($l = fgets($f)) !== false)
        print $l."<br />\n";
      fclose($f);
    }
    else
      print "No data to show.<br />\n";
  }
  else
    print "No data to show.<br />\n";

  print "<br /><hr /><br />\n";

  print "<small><i>Working on <b>".gethostname()."</b></i></small>\n";

?>
</body>
</html>