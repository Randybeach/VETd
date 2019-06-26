import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'sortbyid'
})
export class SortbyidPipe implements PipeTransform {

  transform(messages: any, args?: any): any {
    console.log(messages);

    let count = messages.length;
    while (count > 0){
      for(let i = 1; i < messages.length; i++){
        if(messages[i -1].id > messages[i].id){
          let mes1 = messages[i-1];
          let mes2 = messages[i];
          messages[i-1] = mes2;
          messages[i] = mes1;

      }
  }
      count --;
 }
 console.log(messages);

 return messages;
  }
}


