!     Copyright 2015 Codethink Ltd.
!
!     Licensed under the Apache License, Version 2.0 (the "License");
!     you may not use this file except in compliance with the License.
!     You may obtain a copy of the License at
!
!         http://www.apache.org/licenses/LICENSE-2.0
!
!     Unless required by applicable law or agreed to in writing, software
!     distributed under the License is distributed on an "AS IS" BASIS,
!     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!     See the License for the specific language governing permissions and
!     limitations under the License.

        program EDIT_DESCRIPTOR_WITHOUT_W
            print 20, 1, 2, 3, 'x', 'y', 4
 20         format(2(i3), i5, 1x, a, 1x, a, 1x, i )
            stop
        end
