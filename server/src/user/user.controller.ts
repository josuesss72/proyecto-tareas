import { Controller, Get, Body, Patch, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { UserSession } from 'src/common/entities/user.entity';
import { GetUserReq } from 'src/common/decorators/get-user-req';

@UseGuards(AuthGuard)
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('me/')
  findOne(@GetUserReq() user: UserSession) {
    return this.userService.findOne(user.sub);
  }

  @Patch('me/')
  update(@GetUserReq() user: UserSession, @Body() dto: UpdateUserDto) {
    return this.userService.update(user.sub, dto);
  }
}
