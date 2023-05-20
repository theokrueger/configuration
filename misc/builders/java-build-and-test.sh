#!/bin/bash

# static variables
JUNIT_PATH='../lib/junit-4.12.jar'
HAMCREST_PATH='../lib/hamcrest-core-1.3.jar'
PACKAGE_NAME='app'
TEST_PACKAGE_NAME='test'
MAIN_CLASS='app/AppMain'
TRACE_DEPTH=10


rm -rf ./build
mkdir ./build
cd ./build

# parse args
run_tests='false'
run_program='false'

args=( "$@" )
for arg in ${args[@]}; do
    case $arg in
        'test')
            run_tests='true';;
        'run')
            run_program='true';;
    esac
done

# echo settings
echo "Running Tests: $run_tests"
echo "Running Program: $run_program"

# get list of files to compile
files=($(find .. -name *.java))
java_files=''
java_test_files=''
test_classes=()
for file in ${files[@]}; do
    # dont compile/run tests if not testing
    if [[ "$file" == *"test"* ]]; then
        if [[ "$run_tests" == 'true' ]]; then
            java_test_files="$java_files $file"
            filename=$(basename $file)
            test_classes+="${filename%.*}"
        fi
    else
       java_files="$java_files $file"
    fi
done

# compile to bytecode
echo "Compiling $java_files"
javac $java_files $java_test_files -cp $JUNIT_PATH:$HAMCREST_PATH -d .

# run tests
if [[ "$run_tests" == 'true' ]]; then
    for class in ${test_classes[@]}; do
        echo "Running Test: $class"
        java -XX:MaxJavaStackTraceDepth=$TRACE_DEPTH -classpath $PWD:$JUNIT_PATH:$HAMCREST_PATH org.junit.runner.JUnitCore $TEST_PACKAGE_NAME.$class
    done
fi

# run program
if [[ "$run_program" == 'true' ]]; then
    echo "Running Program Now:"
    dir="$PWD"
    cd ..
    java -classpath $dir $MAIN_CLASS
fi
