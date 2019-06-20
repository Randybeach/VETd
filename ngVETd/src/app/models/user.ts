export class User {
  id: number;
  email: string;
  username: string;
  password: string;
  enabled: boolean;
  role: string;
  profileId: number;

  constructor(
    id?: number,
    email?: string,
    username?: string,
    password?: string,
    enabled?: boolean,
    role?: string,
    profileId?: number
  ) {
    this.id = id;
    this.email = email;
    this.username = username;
    this.password = password;
    this.enabled = enabled;
    this.role = role;
    this.profileId = profileId;
  }
}
