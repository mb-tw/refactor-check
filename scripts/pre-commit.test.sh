SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TEST_COMPONENT_CATCH="function App() {
  return (
        <div className='App'>
            <div>Unrefactored Child Component</div>
        </div>
    )
  };
  export default App;"

TEST_COMPONENT_NO_CATCH="function divdiv() {
    return 'div div';
}"

catch_file_path="$SCRIPT_DIR/temporaryTestFile.should_be_catched.js"
no_catch_file_path="$SCRIPT_DIR/temporaryTestFile.should_not_be_catched.js"

echo $TEST_COMPONENT_CATCH > $catch_file_path
echo $TEST_COMPONENT_NO_CATCH > $no_catch_file_path
git add $catch_file_path $no_catch_file_path

check_output=$($SCRIPT_DIR/pre-commit.sh | tee /dev/fd/2)

should_be_catched=$( echo $check_output | grep -c "temporaryTestFile.should_be_catched.js")
should_not_be_catched=$( echo $check_output | grep -c "temporaryTestFile.should_not_be_catched.js")

if [ $should_be_catched == 1 ] && [ $should_not_be_catched == 0 ]; then
    echo "Test passed ✅"
else 
    echo "Test failed ❌"
fi

# git rm -f $catch_file_path $no_catch_file_path &> /dev/null
