#!/usr/bin/perl
print "\n";
print "*******************************************************************************\n";
print "  ALL Analog Parameter Tune Tool (v7.3)\n";
print "  Author: Noon Chen\n";
print "  A Professional Tool for Test.\n";
print "  ",scalar localtime;
print "\n*******************************************************************************\n";
print "\n";
print "\n";

#########################################################################################
#print "  Checking In: ";
use Term::ReadKey;

#system "stty -echo";
ReadMode('noecho'); # Disable echoing of characters

print "  Password: ";
chomp($Ccode = <STDIN>);
print "\n";
#system "stty echo";
ReadMode('restore'); # Restore terminal mode

  if ($Ccode ne "\@testpro")
  #if ($Ccode ne "TestPro")
   	{
   		print "  >>> password Wrong!\n"; goto END_Prog;
   	}
  else
  	{
   		print "  >>> password Correct.\n\n";
  	}


############################ Excel ######################################################


print "  Please chose 'Extracting' or 'Updating' to continue(E/U) ","\n";
   $choice=<STDIN>;
   chomp $choice;
   $choice = uc$choice;

   if ($choice eq "U") {goto Update;}

print "\n";
print "  Please input [BOARD VERSION] or press [ENTER] to continue\n";
   $version=<STDIN>;
   chomp $version;

if ($version)
  {
  print "\n";
  print "  Version is: $version\n";
  print "\n  Getting all COMP list...\n";
  @analogfiles = <$version/analog/*.o>;
  print "  [DONE]\n\n";
  open (LIST, ">ALLCOMP_Statement_$version");
  open (UnExtFile, ">ALLCOMP_UnExtracted_$version");  
  }
else
  {
  print "\n  Getting all COMP list...\n";
  @analogfiles = <analog/*.o>;
  print "  [DONE]\n\n";
  open (LIST, ">ALLCOMP_Statement");
  open (UnExtFile, ">ALLCOMP_UnExtracted");
  }


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#print substr($line,0,5),"\n";
      	#*************************************** FUSE *************************************************************
      	if (substr($line,0,4) eq "fuse")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "fuse";                                                            	 #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (substr($line,0,6) eq "jumper"){last;}
        elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
        elsif (eof){printf UnExtFile "%-30s", $analogfiles; print UnExtFile"  by code NONE\n"; print "  Warning --> $analogfiles has no parameter found by code NONE!!!\n";last;}
        elsif ($analogfiles =~ "discharge"){last;}
        elsif ($line =~ "powered"){printf UnExtFile "%-30s", $analogfiles; print UnExtFile"  by code PWD\n"; print "  Warning --> $analogfiles has no parameter found by code PWD !!!\n";last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#print substr($line,0,5),"\n";
      	#*************************************** JUMPER ************************************************************
      	if (substr($line,0,6) eq "jumper")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "jumper";                                                             #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
        elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#*************************************** CAPACITOR ********************************************************
      	if (substr($line,0,9) eq "capacitor")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "capacitor";                                                          #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
      	elsif (substr($line,0,6) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#*************************************** RESISTOR *********************************************************
      	if (substr($line,0,8) eq "resistor")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "resistor";                                                           #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
        elsif (substr($line,0,6) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#*************************************** INDUCTOR *********************************************************
      	if (substr($line,0,8) eq "inductor")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "inductor";                                                           #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
        elsif (substr($line,0,6) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
}}



foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$line =~ s/^ +//;														#清除句首空格
      	#*************************************** ZENER ************************************************************
      	if (substr($line,0,5) eq "zener")
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "zener";                                                              #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
      	elsif (substr($line,0,7) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "diode"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$multi = index($line,"\"");
      	$line =~ s/^ +//;														#清除句首空格
      	#print substr($line,0,5),"\n";
      	#*************************************** DIODE ************************************************************
      	if (substr($line,0,5) eq "diode"
          and $multi == -1)
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-20s", "diode";                                                              #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter;
            while ($parameter =~ m/\,/g)
            {printf LIST "%-12s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            last;
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
        elsif (substr($line,0,6) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


foreach $analogfiles (@analogfiles)
{
       $analogfiles =~ s/\.o//g;
       #print LIST "$analogfiles\n";
       #print "Compiling $analogfiles";
       #print "$analogfiles\n";
       #$value = system ("acomp $analogfiles > /dev/null");

open COMP,"<$analogfiles";
 	 #print $analogfiles,"\n";
   while($line = <COMP>)
      {
      	$len = 0;
      	chomp($line);
      	$multi = index($line,"\"");
      	$line =~ s/^ +//;														#清除句首空格
      	#print substr($line,0,5),"\n";
      	#*************************************** DIODE 多项测试 ***************************************************
      	if (substr($line,0,5) eq "diode"
          and $multi > -1)
      	{
        #printf LIST "%-20s", substr($analogfiles,7,length($analogfiles)); print LIST $line,"\n";  #output origional
        printf LIST "%-30s", $analogfiles;                                                         #comp name
        printf LIST "%-10s", "diode";                                                              #comp type
        $parameter = substr($line,index($line,"\ ")+1,length($line));                              #parameter
        $parameter =~ s/\s//g;
        #print $parameter."\n";
            while ($parameter =~ m/\,/g)
            {printf LIST "%-15s",substr($parameter,$len,pos($parameter)-$len);  $len = pos($parameter);}
   	        $sufix = substr($parameter,$len,length($parameter));
            print LIST $sufix;
            print LIST "\n";
            if(eof){last;}
        }
        elsif (eof){last;}
        elsif (substr($line,0,4) eq "fuse"){last;}
        elsif (substr($line,0,6) eq "jumper"){last;}
      	elsif (substr($line,0,5) eq "zener"){last;}
      	elsif (substr($line,0,9) eq "capacitor"){last;}
      	elsif (substr($line,0,8) eq "resistor"){last;}
      	elsif (substr($line,0,8) eq "inductor"){last;}
}}


close LIST;
close UnExtFile;
print "\n";
print "\n";
print "*******************************************************************************\n";
print "**********************  Completed  ********************************************\n";
print "*******************************************************************************\n";
print "  Please check ALLCOMP_Statement for extracted Component\n";
print "  Please check UnExtractFile for ALLCOMP_Unextracted Component\n";

END_Prog:

print "\n";
system 'pause';
#last;
exit;

Update:
 print "\n";
 print "   Multiple Version required ???(N/Y) ","\n";
    $VR=<STDIN>;
    chomp $VR;
    $VR = uc$VR;

#print "\n";

if ($VR eq "Y")
{
 print "   Enter VERSION Name (or press 'Enter' for Base version) ","\n";
    $version=<STDIN>;
    chomp $version;
    $version = uc$version;
    if ($version eq "")
       {$version = '""';}
    print $version,"\n";
}

($sec,$min,$hour,$day,$mon,$year,$wday,$yday,$isdst)=localtime(time());
$year+=1900;
$mon+=1;
#print "$mon-$day-$hour-$min-$sec\n";

print "\n";

print "   Specify file name to be update (or press 'Enter' for 'ALLComp_Statement')\n";
   $file=<STDIN>;
   chomp $file;
    if ($file eq "")
       {$file = "ALLComp_Statement";}
   print "\n";

open (LIST, "<$file");
open (LOG, ">ALLCOMP_LOG-$mon-$day-$hour-$min-$sec\n");

while($device = <LIST>)
{
	#print "\n";
	$ori_param = "";
	$new_param = "";
	chomp;
	if (index($device,"\"") != -1){ last; }
  $dev = substr($device,0,index($device,"\ ")),"\n";        #dev name
  #print $dev,"\n";
  $type = substr($device,30,10);                            #dev type
  $type =~ s/\s//g;
  #print $type,"\n";
  $new_param = substr($device,40,length($device) - 40);     #new dev parameter
  $new_param =~ s/\s//g;
  #print $new_param,"\n";

		#****************************** Hilimit Check ************************************************  	
		if ($type eq "capacitor")
		{
			#print $dev,"\n";
		  $hilimit = (substr($device,60,10));
		  #print $hilimit,"\n";
		  $hilimit =~ s/\s//g;
		  #print $hilimit,"\n";
		  $hilimit = (substr($hilimit,0,index($hilimit,"\,")));
		  #print $hilimit,"\n";
				if($hilimit > "40")
				{
					print "  Warning !!! $dev High Limit out of Range 40%.\n";
					print LOG "  Warning !!! $dev High Limit out of Range 40%.\n";
				}
		}
		elsif ($type eq "resistor")
		{
			#print $dev,"\n";
		  $hilimit = (substr($device,60,10));
		  #print $hilimit,"\n";
		  $hilimit =~ s/\s//g;
		  #print $hilimit,"\n";
		  $hilimit = (substr($hilimit,0,index($hilimit,"\,")));
		  #print $hilimit,"\n";
				if($hilimit > "40")
				{
					print "  Warning !!! $dev High Limit out of Range 40%.\n";
					print LOG "  Warning !!! $dev High Limit out of Range 40%.\n";
				}
		}

		#****************************** Lolimit Check *********************************************
		if ($type eq "capacitor")
		{
			#print $dev,"\n";
		  $hilimit = (substr($device,70,10));
		  #print $hilimit,"\n";
		  $hilimit =~ s/\s//g;
		  #print $hilimit,"\n";
		  $hilimit = (substr($hilimit,0,index($hilimit,"\,")));
		  #print $hilimit,"\n";
				if($hilimit > "40")
				{
					print "  Warning !!! $dev Low Limit out of Range 40%.\n";
					print LOG "  Warning !!! $dev Low Limit out of Range 40%.\n";
				}
		}
		elsif ($type eq "resistor")
		{
			#print $dev,"\n";
		  $hilimit = (substr($device,70,10));
		  #print $hilimit,"\n";
		  $hilimit =~ s/\s//g;
		  #print $hilimit,"\n";
		  $hilimit = (substr($hilimit,0,index($hilimit,"\,")));
		  #print $hilimit,"\n";
				if($hilimit > "40")
				{
					print "  Warning !!! $dev Low Limit out of Range 40%.\n";
					print LOG "  Warning !!! $dev Low Limit out of Range 40%.\n";
				}
		}

    #******************************************************************************************


open(ALL, "<$dev");
open(Temp, ">temp");

  while($line = <ALL>)
  {
  	chomp;
  	$line =~ s/^ +//;
  	  #****************************** Device *******************************************************
    	if (substr($line,0,length($type)) eq $type)
    	{
  			$ori_param = substr($line,index($line,"\ "),length($line)- index($line,"\ "));     #ori parameter
  			#print $line,"\n";
  			$ori_param =~ s/\s//g;
  			$new_param =~ s/\s//g;
  			#print $ori_param,"\n";
  			#print $new_param,"\n";
  				if ($new_param eq $ori_param)
  				{
  					print Temp $type,"\ ",$ori_param,"\n";                      #ori parameter
  				}
  				else
  				{
        		print Temp $type,"\ ",$new_param,"\n";                      #new parameter
        		printf LOG "%-25s", $dev; print LOG "Updated, "; 	        #Log
        		printf "%-25s", $dev; print "Updated, ";                  #display in screen
        	}
      }
      else 
      {
      	print Temp $line;                                               #normal line
      }
      
  }

close ALL;
close Temp;

use Time::HiRes qw ( sleep time );

		############## update device ##############################
		if ($new_param ne $ori_param)
		{
			#unlink NULL;
			sleep (0.1);
			#print $ori_param,"\n";
  		#print $new_param,"\n";
			rename $dev, "$dev~";
			system ("mv","temp", $dev);
			if ($VR eq "Y")
			{$value = system ("acomp -V $version $dev > NULL");}
		  else
		  {$value = system ("acomp $dev -l > NULL");}
      	if ($value eq 0)
      	{
      	  print LOG "  [Object Produced]\n";        #compile passed
      	  print "  [Object Produced]\n";
      	}
      	else
      	{
      		print LOG "    [Compile FAILED!!!]\n";         #compile failed
      		print "    [Compile FAILED!!!]\n";
      	}
				#unlink NULL;
		}
unlink "temp";
}
close LIST;



open (LIST, "<$file");
$dev_ori = "";
############## MULTI TEST ######################################################
while($device = <LIST>)
{
	#print "\n";
	$ori_param = "";
	$new_param = "";
	chomp;
  $dev = substr($device,0,index($device,"\ ")),"\n";        #dev name
  $subname = substr($device,index($device,"\"") + 1, rindex($device,"\"") - index($device,"\"") - 1),"\n";
  #print $subname."\n";
  #print $dev,"\n";
  $type = substr($device,30,10);                            #dev type
  $type =~ s/\s//g;
  #print $type,"\n";
  $new_param = substr($device,55,length($device) - 55);     #new dev parameter
  $new_param =~ s/\s//g;
  #print $new_param,"\n";

  if($dev ne $dev_ori and index($device,"\"") != -1 and $dev_ori ne "" and $dev_u eq "updated")
  {
 		sleep (0.1);
		if ($VR eq "Y")
		{$value = system ("acomp -V $version $dev_ori > NULL");}
		else
		{$value = system ("acomp $dev_ori -l > NULL");}
    	if ($value eq 0)
    	{
    	  print LOG $dev_ori." ----> [Object Produced]\n";        #compile passed
    	  print $dev_ori." ----> [Object Produced]\n";
    	}
    	else
    	{
    		print LOG "  ---->  [Compile FAILED!!!]\n";         #compile failed
    		print "  ---->  [Compile FAILED!!!]\n";
    	}
   }
  if($dev ne $dev_ori) { $dev_u = "";}

   ######################################################################

open(ALL, "<$dev");
open(Temp, ">$dev~");
$dev_ori = $dev;

  while($line = <ALL>)
  {
  	chomp;
  	$line =~ s/^ +//;
    $subname1 = substr($line,index($line,"\"") + 1, rindex($line,"\"") - index($line,"\"") - 1),"\n";
  	  #****************************** Device *******************************************************
    	if (substr($line,0,length($type)) eq $type and $subname eq $subname1)
    	{
  			$ori_param = substr($line,index($line,"\,")+1,length($line)- index($line,"\,"));     #ori parameter
  			#print $line,"\n";
  			$ori_param =~ s/\s//g;
  			$new_param =~ s/\s//g;
  			#print $ori_param,"\n";
  			#print $new_param,"\n";
  				if ($new_param eq $ori_param)
  				{
  					print Temp $type,"\ \"",$subname1, "\"\,", $ori_param,"\n";                      #ori parameter
  				}
  				else
  				{
        		print Temp $type,"\ \"",$subname1, "\"\,",$new_param,"\n";                      #new parameter
        		printf LOG "%-20s", $dev; print LOG "/".$subname; print LOG " Updated ". "\n"; 	        #Log
        		printf "%-20s", $dev; print "/".$subname; print " Updated ". "\n";                  #display in screen
        		$dev_u = "updated";
        		#$dev_u = "U";
        		#print $dev_u."\n";
        		#print $dev."\n";
        	}
      }
      else 
      {
      	print Temp $line;                                               #normal line
      }
  }
  use Time::HiRes qw ( sleep time );
  ############# compile #################################################
  #print $dev."\n";
  #print $dev_ori."\n";
  #print $device."\n";

close ALL;
close Temp;
rename $dev, $dev.".bak";
system ("mv",$dev."~", $dev);
}

  if($dev_u eq "updated")
  {
 			sleep (0.1);
			if ($VR eq "Y")
			{$value = system ("acomp -V $version $dev > NULL");}
		  else
		  {$value = system ("acomp $dev -l > NULL");}
      	if ($value eq 0)
      	{
      	  print LOG $dev." -----> [Object Produced]\n";        #compile passed
      	  print $dev." -----> [Object Produced]\n";
      	}
      	else
      	{
      		print LOG " ----->   [Compile FAILED!!!]\n";         #compile failed
      		print "  ----->  [Compile FAILED!!!]\n";
      	}
	}

close LIST;

unlink NULL;
close LOG;

print  "\n\n  Completed. Please check ALLCOMP_LOG for updated.\n";

END_Prog:

print "\n";
system 'pause';

