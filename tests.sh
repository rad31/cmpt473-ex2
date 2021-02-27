#!/bin/bash
rm ./TestOutput/Messages/*
rm ./TestOutput/Files/*

# Test 1
xml2csv --limit 0 --buffer 0 \
> ./TestOutput/Messages/Test1.txt 2> ./TestOutput/Messages/Test1.txt 

# Test 2
touch ./TestOutput/Files/Test2.csv
xml2csv --input ./TestData/TestFiles/valid.xml --output ./TestOutput/Files/Test2.csv --tag person --delimiter : --limit 0 --ignore age --buffer 500 --encoding UTF-8 \
> ./TestOutput/Messages/Test2.txt 2> ./TestOutput/Messages/Test2.txt

# Test 3
touch ./TestOutput/Files/Test3.csv
xml2csv --output ./TestOutput/Files/Test1.csv --tag none --delimiter : --limit 0 --buffer 1000 --encoding none \
> ./TestOutput/Messages/Test3.txt 2> ./TestOutput/Messages/Test3.txt

# Test 4
xml2csv --input ./no-file.xml --tag person --limit 0 --ignore age --buffer 2000 \
> ./TestOutput/Messages/Test4.txt 2> ./TestOutput/Messages/Test4.txt

# Test 5
xml2csv --input ./TestData/TestFiles/valid.xml --delimiter : --limit 1 --buffer 0 --encoding UTF-8 \
> ./TestOutput/Messages/Test5.txt 2> ./TestOutput/Messages/Test5.txt

# Test 6
xml2csv --output ./TestOutput/Files/Test2.csv --limit 1 --ignore age --buffer 500 \
> ./TestOutput/Messages/Test6.txt 2> ./TestOutput/Messages/Test6.txt

# Test 7
xml2csv --input ./TestData/TestFiles/valid.xml --tag person --limit 1 --buffer 1000 \
> ./TestOutput/Messages/Test7.txt 2> ./TestOutput/Messages/Test7.txt

# Test 8
touch ./TestOutput/Files/Test8.csv
xml2csv --output ./TestOutput/Files/Test3.csv --delimiter : --limit 1 --buffer 2000 \
> ./TestOutput/Messages/Test8.txt 2> ./TestOutput/Messages/Test8.txt

# Test 9
touch ./TestOutput/Files/Test9.csv
xml2csv --input ./TestData/TestFiles/invalid.xml --output ./TestOutput/Files/Test4.csv --tag person --limit 3 --ignore age --buffer 0 --encoding UTF-8 \
> ./TestOutput/Messages/Test9.txt 2> ./TestOutput/Messages/Test9.txt

# Test 10
xml2csv --delimiter : --limit 3 --buffer 500 \
> ./TestOutput/Messages/Test10.txt 2> ./TestOutput/Messages/Test10.txt

# Test 11
touch ./TestOutput/Files/Test11.csv
xml2csv --input ./TestData/TestFiles/valid.xml --output ./TestOutput/Files/Test5.csv --limit 3 --ignore age --buffer 1000 --encoding UTF-8 \
> ./TestOutput/Messages/Test11.txt 2> ./TestOutput/Messages/Test11.txt

# Test 12
xml2csv --input ./TestData/TestFiles/valid.xml --tag person --limit 3 --ignore none --buffer 2000 --encoding UTF-8 \
> ./TestOutput/Messages/Test12.txt 2> ./TestOutput/Messages/Test12.txt

# Test 13
touch ./TestOutput/Files/Test13.csv
xml2csv --input ./no-file.xml --output ./TestOutput/Files/Test13.csv --tag person --limit 4 --ignore none --buffer 0 --encoding UTF-8 \
> ./TestOutput/Messages/Test13.txt 2> ./TestOutput/Messages/Test13.txt

# Test 14
xml2csv --delimiter : --limit 4 --buffer 500 \
> ./TestOutput/Messages/Test14.txt 2> ./TestOutput/Messages/Test14.txt

# Test 15
xml2csv --input ./TestData/TestFiles/valid.xml --tag none --limit 4 --ignore age --buffer 1000 \
> ./TestOutput/Messages/Test15.txt 2> ./TestOutput/Messages/Test15.txt

# Test 16
xml2csv --tag person --delimiter : --limit 4 --ignore none --buffer 2000 --encoding UTF-8 \
> ./TestOutput/Messages/Test16.txt 2> ./TestOutput/Messages/Test16.txt

# Test 17
touch ./TestOutput/Files/Test17.csv
xml2csv --input ./no-file.xml --output ./TestOutput/Files/Test17.csv --tag person --ignore age --buffer 0 --encoding none \
> ./TestOutput/Messages/Test17.txt 2> ./TestOutput/Messages/Test17.txt

# Test 18
xml2csv --delimiter : --buffer 500 \
> ./TestOutput/Messages/Test18.txt 2> ./TestOutput/Messages/Test18.txt

# Test 19
xml2csv --input ./TestData/TestFiles/valid.xml --ignore age --buffer 1000 --encoding UTF-8 \
> ./TestOutput/Messages/Test19.txt 2> ./TestOutput/Messages/Test19.txt

# Test 20
touch ./TestOutput/Files/Test20.csv
xml2csv --input ./TestData/TestFiles/invalid.xml --output ./TestOutput/Files/Test20.csv --tag none --delimiter : --buffer 2000 \
> ./TestOutput/Messages/Test20.txt 2> ./TestOutput/Messages/Test20.txt

# Test 21
xml2csv --input ./no-file.xml --output ./TestOutput/Files/Test21.csv --tag none --limit -1 --ignore none --buffer 1000 \
> ./TestOutput/Messages/Test21.txt 2> ./TestOutput/Messages/Test21.txt

testsPassed=0

for i in {1..21}
do
    diff ./TestOutput/Messages/Test$i.txt ./TestData/ExpectedMessages/Test$i.txt 1> /dev/null 2> /dev/null
    messageDiff=$?
    isValid="$(cat ./TestData/ExpectedMessages/Test$i.txt | grep "Wrote")"
    if [ "$isValid" != "" ]; then
        diff ./TestOutput/Files/Test$i.csv ./TestData/ExpectedOutput/Test$i.csv 1> /dev/null 2> /dev/null
        contentDiff=$?
    fi
    if [ "$contentDiff" == "0" ] && [ "$messageDiff" == "0" ]; then
        testsPassed=$((testsPassed+1))
        echo "Test$i passed"
    else
        echo "Test$i failed"
    fi
done

echo "$testsPassed/21 Tests Passed"
