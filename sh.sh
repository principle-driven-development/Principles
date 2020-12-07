for changed_file in anothem.md compute-properties-when-possible.md core-logic-separate-from-framework.md documentation-close-to-code.md invisible-visible.md; do
    if [[ $changed_file == *.md ]] && [[ $changed_file != README.md ]]; then
        echo "Do something with this ${changed_file}."
        output="$(cat $changed_file)"
        curlOutput=$(curl --location -w '\n\nStatusCode:%{http_code}'  --request PUT 'https://t1h8ftxrq4.execute-api.eu-west-2.amazonaws.com/default/validator-prod' --header 'Content-Type: text/plain' --data-raw "${output}")
        statusCode=${curlOutput:(-3)}

        if [[ $statusCode == "200" ]]; then
            echo "VALID: ${changed_file}"
        else
            echo "FAILED Validation: ${changed_file}: ${curlOutput%StatusCode*}"
            exit 1
        fi
    fi
done