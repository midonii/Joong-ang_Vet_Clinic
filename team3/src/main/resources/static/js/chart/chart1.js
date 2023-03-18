/**
 * 시라
 */

/* 접수현황 */
      $(function() {
         $.post({
            url : "/receiveboard",
            dataType : "json"
         }).done( function(data) {
            let receiveboard = data.receiveboard;
            var table = "<table class='table table-sm text-center' style='margin-top:-8px;'>";
                     
            for (let i = 0; i < receiveboard.length; i++) {
               var bno = receiveboard[i].bno;
               var pet_name = receiveboard[i].pet_name;
               var type_name = receiveboard[i].type_name;
               var pet_no = receiveboard[i].pet_no;
               var owner_name = receiveboard[i].owner_name;
               var receive_time = receiveboard[i].receive_time;
               var receive_state = receiveboard[i].receive_state;
               var reservation_date = receiveboard[i].reservation_date;
               var type_name = receiveboard[i].type_name;
               
               table += "<tr>";
               table += "<td class='col-1' style='vertical-align: middle' >"+ bno +"</td>";
               table += "<td class='col-2'><span class=' badge  rounded-pill bgtime1 '>접</span>&nbsp;"+ receive_time +"<br>";
               table += "<span class=' badge  rounded-pill bgtime2 '>예</span>&nbsp;"+reservation_date+"</td>";
               table += "<td class='col-5'>"+"<a href='#' style='text-decoration: none;'><b>"+ pet_name +"&nbsp;("+type_name+")"+"</b></a><br>"+owner_name+"</td>";
               if(receive_state == 1){
                  table += "<td style='vertical-align: middle'><span class='badge text-bg-primary'>진료대기</span></td>";
               }else {
                  table += "<td style='vertical-align: middle'><span class='badge text-bg-danger'>진료중</span></td>";
                  
               }
               table += "<td class='col-3'><button class='btn btn-sm btn-primary recbtn'>호출</button></td>";
               
               table += "</tr>";
               
            }
            $("#receiveboard").append(table);
			
         });

      });