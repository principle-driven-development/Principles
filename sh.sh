for changed_file in core-logic-separate-from-framework.md; do
    if [[ $changed_file == *.md ]] && [[ $changed_file != README.md ]];
    then
        echo "Do something with this ${changed_file}."
        output="$(cat $changed_file)"
        # echo "$output"
        curlOutput=$(curl --location -w '\n\nStatusCode:%{http_code}'  --request PUT 'https://t1h8ftxrq4.execute-api.eu-west-2.amazonaws.com/default/validator-prod' --header 'Content-Type: text/plain' --data-raw "${output}")

        if ${curlOutput:(-3)} == 200:
        then
            echo "SUCCESS!"
        else
            echo "FAILED"
            echo ${curlOutput%StatusCode*}
        fi
    fi
done