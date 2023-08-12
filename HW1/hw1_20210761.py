import mysql.connector

##########
# Connect database
# change the password to pw1 and userID to id
print('ID ?')
id = input()
print('PW ?')
pw1 = input()
##########
con = mysql.connector.connect(host='127.0.0.1', user='root', password='salam123', db='hw1', charset='utf8mb4')
# after each statement, I will have to commit in Python

###########
# Disconnect database
print('What do you want to do?')
print('1. Register a course')
print('2. Drop a course')
print('3. Registered credit averages of N students')
print('4. CGPA rank within department')
print('5. Find a headmentor')
command = input()
print('Input?')
###########
args = input()
command = int(command)
sum_credits_cur = con.cursor(prepared=True)
sum_credits_query = "SELECT SUM(credits) FROM TAKES NATURAL JOIN COURSE WHERE studentID = %s AND semester = %s"
if command == 1:
    # print("Salam")
    studentID = int(args.split()[0])
    semester = args.split()[1]
    courseID = args.split()[2]
    # print(studentID, semester, courseID)
    # check the validity of input
    cur1 = con.cursor(prepared = True)
    query1 = "SELECT COUNT(*) FROM TAKES WHERE studentID = %s AND courseID = %s"
    cur1.execute(query1, (studentID, courseID))
    cnt_takes = cur1.fetchone()[0]
    # print("cnt_takes = " + str(cnt_takes))
    # print(cnt_takes)
    if cnt_takes: # invalid case 1
        # print("Register Denied 1") # write to output file
        sum_credits_cur.execute(sum_credits_query, (studentID, semester))
        row = sum_credits_cur.fetchone()
        x = row[0] if row[0] else 0
        # print(row)
        # print(row[0]) # write to output file
        with open("output_20210761.txt", 'w', encoding='utf8') as of:
            of.write("Register Denied\n")
            of.write(str(x) + '\n')
    else:
        cur3 = con.cursor(prepared = True)
        query3 = "SELECT COUNT(*) FROM TEACHES WHERE courseID = %s AND semester = %s"
        cur3.execute(query3, (courseID, semester))
        cnt_teaches = cur3.fetchone()[0]
        # print("first_row = " + str(cnt_teaches))
        if not cnt_teaches: # invalid case 2
            # print("Register Denied 2")
            sum_credits_cur.execute(sum_credits_query, (studentID, semester))
            row = sum_credits_cur.fetchone()
            x = row[0] if row[0] else 0
            # print(row[0]) # write to output file
            with open("output_20210761.txt", 'w', encoding='utf8') as of:
                of.write("Register Denied\n")
                of.write(str(x) + '\n')
        else:
            sum_credits_cur.execute(sum_credits_query, (studentID, semester))
            x = sum_credits_cur.fetchone()
            total_credits = x[0] if x[0] else 0
            cur7 = con.cursor(prepared = True)
            query7 = "SELECT credits FROM COURSE WHERE courseID = %s"
            # print(type(courseID))
            cur7.execute(query7, (courseID, ))
            x = cur7.fetchone()
            course_credits = x[0] if x[0] else 0
            # print("total_credits = " + str(total_credits))
            # print("course_credits = " + str(course_credits))
            if ((semester in ('Fall', 'Spring') and total_credits + course_credits > 24) or (semester in ('Summer', 'Winter') and total_credits + course_credits > 3)): # invalid case 3
                # print("Register denied 3")
                with open("output_20210761.txt", 'w', encoding='utf8') as of:
                    of.write("Register Denied\n")
                    of.write(str(total_credits) + '\n')
            else:
                cur6 = con.cursor(prepared = True)
                query6 = "INSERT INTO TAKES (semester, studentID, courseID) VALUES (%s, %s, %s)"
                cur6.execute(query6, (semester, studentID, courseID))
                con.commit()
                with open("output_20210761.txt", 'w', encoding='utf8') as of:
                    of.write("Register Completed\n")
                    of.write(str(total_credits + course_credits) + '\n')
                # print("Successfully registered\n")
                
elif command == 2:
    # print("Salam")
    studentID = int(args.split()[0])
    semester = args.split()[1]
    courseID = args.split()[2]
    # check the validity of input
    cur8 = con.cursor(prepared = True)
    query8 = "SELECT COUNT(*) FROM TEACHES WHERE courseID = %s AND semester = %s"
    cur8.execute(query8, (courseID, semester))
    cnt_teaches = cur8.fetchone()[0]
    # print("first_row = " + str(cnt_teaches))
    if not cnt_teaches:
        # print("Register Denied 1")
        sum_credits_cur.execute(sum_credits_query, (studentID, semester))
        row = sum_credits_cur.fetchone()
        x = row[0] if row[0] else 0
        # print(row[0]) # write to output file
        with open("output_20210761.txt", 'w', encoding='utf8') as of:
            of.write("Drop Denied\n")
            of.write(str(x) + '\n')
    else:
        cur10 = con.cursor(prepared = True)
        query10 = "SELECT COUNT(*) FROM TAKES WHERE studentID = %s AND courseID = %s AND semester = %s"
        cur10.execute(query10, (studentID, courseID, semester))
        cnt_takes = cur10.fetchone()[0]
        if not cnt_takes:
            # print("Register Denied 2")
            sum_credits_cur.execute(sum_credits_query, (studentID, semester))
            row = sum_credits_cur.fetchone()
            x = row[0] if row[0] else 0
            # print(row[0]) # write to output file
            with open("output_20210761.txt", 'w', encoding='utf8') as of:
                of.write("Drop Denied\n")
                of.write(str(x) + '\n')
        else:
            cur12 = con.cursor(prepared = True)
            query12 = "DELETE FROM TAKES WHERE studentID = %s AND courseID = %s AND semester = %s"
            cur12.execute(query12, (studentID, courseID, semester))
            con.commit()
            sum_credits_cur.execute(sum_credits_query, (studentID, semester))
            row = sum_credits_cur.fetchone()
            x = row[0] if row[0] else 0
            with open("output_20210761.txt", 'w', encoding='utf8') as of:
                of.write("Drop Completed\n")
                of.write(str(x) + '\n')
            # print("Successfully deleted\n")

elif command == 3:
    # print("Salam")
    studentID = int(args.split()[0])
    N = int(args.split()[1])
    cur14 = con.cursor(prepared = True)
    query14 = "SELECT studentID FROM STUDENT WHERE studentID >= %s ORDER BY studentID ASC"
    cur14.execute(query14, (studentID, ))
    rows = cur14.fetchall()
    # print(rows)
    rows = rows[:N]
    credits_sum = 0
    for i in range(N):
        row = rows[i]
        id = row[0]
        cur15 = con.cursor(prepared=True)
        query15 = "SELECT SUM(credits) FROM TAKES NATURAL JOIN COURSE WHERE studentID = %s"
        cur15.execute(query15, (id, ))
        tmp_row = cur15.fetchone()
        tmp_credits = tmp_row[0] if tmp_row[0] else 0
        # print(tmp_row, tmp_credits)
        credits_sum += tmp_credits
    with open("output_20210761.txt", 'w', encoding='utf8') as of:
        of.write(str(credits_sum / N) + '\n')

elif command == 4:
    # print("Salam")
    studentID = int(args.split()[0])
    cur16 = con.cursor(prepared = True)
    query16 = "SELECT deptName FROM STUDENT WHERE studentID = %s"
    cur16.execute(query16, (studentID, ))
    deptName = cur16.fetchone()[0]
    cur17 = con.cursor(prepared = True)
    query17 = "SELECT CGPA FROM STUDENT WHERE deptName = %s ORDER BY CGPA DESC"
    cur17.execute(query17, (deptName, ))
    grades = cur17.fetchall()
    cur18 = con.cursor(prepared = True)
    query18 = "SELECT CGPA FROM STUDENT WHERE studentID = %s"
    cur18.execute(query18, (studentID, ))
    cgpa = cur18.fetchone()[0]
    rank = 0
    for i in grades:
        rank += 1
        if i[0] == cgpa:
            break
    with open("output_20210761.txt", 'w', encoding='utf8') as of:
        of.write(str(rank) + '\n')

else:
    # print("Salam")
    studentID = int(args.split()[0])
    cur19 = con.cursor(prepared = True)
    query19 = "SELECT MentorID from STUDENT WHERE studentID = %s"
    cur19.execute(query19, (studentID, ))
    mentorID = cur19.fetchone()[0]
    while (studentID != mentorID) :
        studentID = mentorID
        cur19.execute(query19, (studentID, ))
        mentorID = cur19.fetchone()[0]
    with open("output_20210761.txt", "w", encoding='utf8') as of:
        of.write(str(mentorID) + '\n')

# Optimize the code in the end.
# Test rigorously
# Closing the connection in the end
con.close()