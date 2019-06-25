import { Profile } from './models/profile';
import { Message } from './models/message';

export interface DialogData {
  profile: Profile;
  myProfile: Profile;
  messages: Message[];

}
