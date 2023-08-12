<%@ include file="header.jsp" %>
<%@ include file="session_check.jsp" %>

<a href="/logout.jsp"><%=user_id%> Logout</a>

<h1> Schedule </h1>

<label for="search"> Search: </label>
<input type="text" name="search" id="search">
<br><br>

<table id="schetable" border="1" style="text-align:center">
    <thead> <td>Code</td><td>Name</td><td>Start time</td><td>End time</td><td>Day of the Week</td></thead>
    <tbody>
    </tbody>
</table>

<h1> Form </h1>
<label for="name"> Name </label>
<input type="text"  name="name"  id="name"><br>
<label for="start"> Start time </label>
<input type="number" name="start" id="start" min="0" max="23"> <br>
<label for="end"> End time </label>
<input type="number" name="end"  id="end" min="1" max="24"><br>
<label for="dow"> Day of the week </label>
<select name="dow" id="dow">
    <option value="Sun"> Sun </option>
    <option value="Mon"> Mon </option>
    <option value="Tue"> Tue </option>
    <option value="Wed"> Wed </option>
    <option value="Thu"> Thu </option>
    <option value="Fri"> Fri </option>
    <option value="Sat"> Sat </option>
</select> <br>
<button id="submit_btn">Submit</button>

<script>

    const schetable = $('#schetable');
    const searchInput = $('#search');

    function append_tr(obj) {
        const tbody = schetable.children('tbody'); // grab tbody
        let tr = $('<tr>'); // all table rows

        for (const key of ['code', 'name', 'start', 'end', 'dow'])
        {
            let td = $('<td>'); // all data
    
            td.attr('code', obj['code']); // set one or more attributes for the set of matched elements
            td.text(obj[key]); // set the content of each elements in set to given text
            console.log(key + " " + String(obj[key]));

            if (key == 'code')
                td.on('click', del_func);

            tr.append(td);
        }
        tbody.append(tr);
    }

    function delete_tr(tr) {
        tr.remove();
    }

    $(document).ready(function() {

        $.ajax({
            url: "./sche_view.jsp",
            type: "GET",
            success: function(resArr) {
                console.log("LOADING SUCCESS");
                let result = JSON.parse(resArr);
                if (result[0]['valid'] == 1) {
                    console.log("Oh yes");
                    let l = result.length;
                    for (let i = 1; i < l; i ++) {
                        append_tr(result[i]);
                    }
                }
                console.log(result);
            },
            error: function() {
                alert('error');
            }
        });

        $('#submit_btn').click(function() {

            let formData = {
                name: $("#name").val(),
                start: $("#start").val(),
                end: $("#end").val(),
                dow: $("#dow").find(":selected").val()
            };

            $.ajax({
                url: "./sche_insert.jsp",
                type: "GET",
                data: formData,
                success: function(res) {
                    console.log("SUCCESS");
                    let obj = JSON.parse(res);
                    console.log(obj);
                    if (obj['valid'] == 1) append_tr(obj);
                },
                error: function() {
                    alert('error');
                }
            })
        });
    })

    // obj is some js object, has name att

    // clears table
    function clear_table() {
        schetable.children('tbody').html('');
    }

    function del_func (event) {
        // your codes here
        // alert('Salam');
        let value = $(event.target).text();
        let argData = {
            code: value
        };
        delete_tr($(event.target).parent());
        $.ajax({
            url: "./sche_delete.jsp",
            type: "GET",
            data: argData,
            success: function() {
                console.log("DELETE SUCCESS");
            },
            error: function() {
                alert('error');
            }
        })
    }

    $("#search").on('change', refresh_table);

    function refresh_table(event) {
        // your codes here

        let value = $(event.target).val();
        let argData = {
            search: value,
        };
        $.ajax({
            url: "./sche_select.jsp",
            type: "GET",
            data: argData,
            success: function(resArr) {
                clear_table();
                console.log("REFRESH SUCCESS");
                let result = JSON.parse(resArr);
                if (result[0]['valid'] == 1) {
                    console.log("Oh yes");
                    let l = result.length;
                    for (let i = 1; i < l; i ++) {
                        append_tr(result[i]);
                    }
                }
                console.log(result);
            },
            error: function() {
                alert('error');
            }
        })
    }

    // your codes here
    
    /* $('#submit_btn').click(
        // your codes here
    ); */

</script>
<%@ include file="footer.jsp" %>