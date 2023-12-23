# Documentation:
[parallel doc url](https://www.gnu.org/software/parallel/parallel_tutorial.html)

# On Milan nodes
```
ssh milan

ml other/parallel/20230822

parallel -h
```

## test1

discover36.sakella 1084> cat test.csh
```
#!/bin/csh -f

set dd0=`date`

foreach id (`seq 1 10`)
  echo $id
end

set dd1=`date`
echo $dd0
echo $dd1
```

Try:
```
parallel ::: test.csh
parallel -j 2 ::: test.csh
```

## test2
discover36.sakella 1191> cat test1.csh 
```
#!/bin/csh -f

set input=$1

set dd0=`date`

foreach id (`seq 1 $input`)
  foreach idd (`seq 1 $id`)
    echo $id":"$idd
  end
  echo " "
end

set dd1=`date`
echo "START: "$dd0
echo "END: "$dd1
```
parallel -j 2 test1.csh ::: 10 20 <-- check with `top` this runs a **single** job!

## test 3-- checked with `top`
1. `command` is: echo, arguments are: foo, bar: `parallel echo ::: foo bar`
2. Change arguments: parallel echo ::: `seq 1 100`
3. Run as `6` jobs: parallel -j 6 echo ::: `seq 1 100`
4. Dry run: parallel --dry-run -j 6 test.csh ::: `seq 1 100` and **real**: parallel -j 6 test.csh ::: `seq 1 10`

## test 4-- checkec with `top`

**script**: discover36.sakella 1293> cat test.csh 
```
#!/bin/csh -f

set dd0=`date`

set input=$1
foreach line (`cat $input`)
  set input=$line

  foreach id (`seq 1 $input`)
   foreach idd (`seq 1 $id`)
     echo $id":"$idd
   end
  echo " "
  end
end

set dd1=`date`
echo "START: "$dd0
echo "END: "$dd1
```
**inputs**: in 2 files (as you would have)
```
discover36.sakella 1295> cat input1.txt 
1
100
discover36.sakella 1296> 
discover36.sakella 1296> cat input2.txt 
1000
```
**run**: `parallel -j 6 test.csh ::: input1.txt input2.txt` or `parallel test.csh ::: input1.txt input2.txt input2.txt` 
Always do a dry run!
